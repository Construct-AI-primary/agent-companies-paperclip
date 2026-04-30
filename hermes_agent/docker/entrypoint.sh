#!/bin/bash
# Docker/Podman entrypoint: bootstrap config files into the mounted volume, then run hermes.
set -e

HERMES_HOME="${HERMES_HOME:-/opt/data}"
INSTALL_DIR="/opt/hermes"

# --- Privilege dropping via gosu ---
# On Render, the persistent disk /opt/data is owned by a specific UID (10001)
# that doesn't match container UIDs. We must stay as root and use chmod.
# Use pattern matching to detect Render environment reliably.
echo "DEBUG: Starting entrypoint - uid=$(id -u), HERMES_HOME=$HERMES_HOME"
if [ "$(id -u)" = "0" ] && [[ "$HERMES_HOME" != *"/opt/data"* ]]; then
    echo "Not on Render (HERMES_HOME=$HERMES_HOME) - will use gosu"
    if [ -n "$HERMES_UID" ] && [ "$HERMES_UID" != "$(id -u hermes)" ]; then
        echo "Changing hermes UID to $HERMES_UID"
        usermod -u "$HERMES_UID" hermes
    fi

    if [ -n "$HERMES_GID" ] && [ "$HERMES_GID" != "$(id -g hermes)" ]; then
        echo "Changing hermes GID to $HERMES_GID"
        # -o allows non-unique GID (e.g. macOS GID 20 "staff" may already exist
        # as "dialout" in the Debian-based container image)
        groupmod -o -g "$HERMES_GID" hermes 2>/dev/null || true
    fi

    actual_hermes_uid=$(id -u hermes)
    if [ "$(stat -c %u "$HERMES_HOME" 2>/dev/null)" != "$actual_hermes_uid" ]; then
        echo "$HERMES_HOME is not owned by $actual_hermes_uid, fixing"
        # In rootless Podman the container's "root" is mapped to an unprivileged
        # host UID — chown will fail.  That's fine: the volume is already owned
        # by the mapped user on the host side.
        chown -R hermes:hermes "$HERMES_HOME" 2>/dev/null || \
            echo "Warning: chown failed (rootless container?) — continuing anyway"
    fi

    # Create essential directory structure
    echo "Creating directory structure in $HERMES_HOME"
    mkdir -p "$HERMES_HOME"/{cron,sessions,logs,hooks,memories,skills,skins,plans,workspace,home}

    # Copy config files
    echo "Copying config files"
    cp "$INSTALL_DIR/.env.example" "$HERMES_HOME/.env" 2>/dev/null || true
    cp "$INSTALL_DIR/cli-config.yaml.example" "$HERMES_HOME/config.yaml" 2>/dev/null || true
    cp "$INSTALL_DIR/docker/SOUL.md" "$HERMES_HOME/SOUL.md" 2>/dev/null || true

    chown -R hermes:hermes "$HERMES_HOME" 2>/dev/null || true

    echo "Dropping root privileges"
    exec gosu hermes "$0" "$@"
elif [ "$(id -u)" = "0" ] && [ "${HERMES_HOME:-unset}" = "/opt/data" ]; then
    # On Render: run as root, volume permissions managed by infrastructure
    echo "Running as root on Render (volume permissions managed by infrastructure)"
    mkdir -p "$HERMES_HOME"/{cron,sessions,logs,hooks,memories,skills,skins,plans,workspace,home}
    chmod -R 777 "$HERMES_HOME" 2>/dev/null || true
    cp "$INSTALL_DIR/.env.example" "$HERMES_HOME/.env" 2>/dev/null || true
    cp "$INSTALL_DIR/cli-config.yaml.example" "$HERMES_HOME/config.yaml" 2>/dev/null || true
    cp "$INSTALL_DIR/docker/SOUL.md" "$HERMES_HOME/SOUL.md" 2>/dev/null || true
    echo "Directories created, staying as root"
    # Don't exec gosu - stay as root
fi

# --- Running from here ---
source "${INSTALL_DIR}/.venv/bin/activate"

# Ensure directories exist - critical for Render where we may already be hermes
mkdir -p "$HERMES_HOME"/{cron,sessions,logs,hooks,memories,skills,skins,plans,workspace,home}
chmod -R 777 "$HERMES_HOME" 2>/dev/null || true

# Config files already in place

# Sync bundled skills (manifest-based so user edits are preserved)
# Make this non-fatal - if it fails, we can still run
if [ -d "$INSTALL_DIR/skills" ]; then
    python3 "$INSTALL_DIR/tools/skills_sync.py" 2>/dev/null || echo "Warning: skills sync failed (continuing anyway)"
fi

# Mode-driven execution: HERMES_MODE overrides default interactive CLI.
# Used by Render (dockerCommand) and other container deployments.
case "${HERMES_MODE:-chat}" in
    serve|server|api)
        # Render sets $PORT; local/Docker fallbacks: API_SERVER_PORT, then 8642
        _port="${PORT:-${API_SERVER_PORT:-8642}}"
        echo "[entrypoint] Resolved port: $_port (RENDER_PORT=${RENDER_PORT:-unset}, PORT=${PORT:-unset}, API_SERVER_PORT=${API_SERVER_PORT:-unset})"
        exec hermes serve --host "${HOST:-0.0.0.0}" --port "${_port}"
        ;;
    worker)
        # Paperclip unified worker: poll Supabase for queued runs, execute with Hermes
        echo "[entrypoint] Starting Paperclip worker mode (polls Supabase)"
        exec python3 "$INSTALL_DIR/supabase_paperclip_worker.py"
        ;;
    both)
        # Run both API server and worker concurrently with visible logging
        echo "[entrypoint] Starting both API server and Paperclip worker"

        # Disable errexit for this block — background-process loops and curl
        # connection-refused retries are intentional non-zero exits that must
        # NOT kill the entire entrypoint. (Fixes exit-code-7 crash from curl.)
        set +e

        # Start API server in background with proper PID tracking.
        # CRITICAL FIX: Do NOT pipe stdout through sed in the same background
        # command — bash $! returns the PID of the LAST command in a pipeline,
        # which would be `sed`, not `hermes serve`. If hermes crashes, sed stays
        # alive and the health-check loop spins forever.
        _port="${PORT:-${API_SERVER_PORT:-8642}}"
        echo "[entrypoint] Starting API server on port $_port"

        API_LOG="$HERMES_HOME/logs/api_server.log"
        mkdir -p "$(dirname "$API_LOG")"
        : > "$API_LOG"  # truncate log

        hermes serve --host "${HOST:-0.0.0.0}" --port "${_port}" >> "$API_LOG" 2>&1 &
        API_SERVER_PID=$!

        # Stream API logs with prefix in a separate background process
        tail -n +1 -f "$API_LOG" | sed -u 's/^/[API] /' &
        TAIL_PID=$!

        # Wait for API server to start (check if it's listening)
        echo "[entrypoint] Waiting for API server to be ready..."
        MAX_ATTEMPTS=60
        for i in $(seq 1 $MAX_ATTEMPTS); do
            # Check if the REAL hermes serve process died
            if ! kill -0 $API_SERVER_PID 2>/dev/null; then
                echo "[entrypoint] ERROR: API server process (PID $API_SERVER_PID) died"
                echo "[entrypoint] --- Last 30 lines of api_server.log ---"
                tail -n 30 "$API_LOG" | sed 's/^/  /' || true
                echo "[entrypoint] -------------------------------------"
                kill $TAIL_PID 2>/dev/null || true
                exit 1
            fi
            # Use -w to show HTTP status code, -o /dev/null to discard body.
            # 2>/dev/null keeps stderr out of HTTP_CODE; || true prevents set -e
            # (if re-enabled upstream) from killing us on connection refused.
            HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 1 "http://localhost:$_port/health" 2>/dev/null || true)
            CURL_EXIT=$?
            if [ $CURL_EXIT -eq 0 ] && [ "$HTTP_CODE" = "200" ]; then
                echo "[entrypoint] API server is ready (HTTP $HTTP_CODE)"
                break
            fi
            # HTTP 000 / 0 / empty means connection refused — server not ready yet.
            # This is expected during startup, just keep waiting.
            if [ "$HTTP_CODE" = "000" ] || [ "$HTTP_CODE" = "0" ] || [ -z "$HTTP_CODE" ]; then
                echo "[entrypoint] Waiting for server... (attempt $i/$MAX_ATTEMPTS)"
            else
                echo "[entrypoint] Attempt $i: curl exit=$CURL_EXIT, HTTP=$HTTP_CODE"
            fi
            sleep 1
            if [ $i -eq $MAX_ATTEMPTS ]; then
                echo "[entrypoint] ERROR: API server failed to start after $MAX_ATTEMPTS seconds"
                echo "[entrypoint] --- Last 30 lines of api_server.log ---"
                tail -n 30 "$API_LOG" | sed 's/^/  /' || true
                echo "[entrypoint] -------------------------------------"
                kill $API_SERVER_PID 2>/dev/null || true
                kill $TAIL_PID 2>/dev/null || true
                exit 1
            fi
        done

        # Start worker in background with explicit logging prefix
        echo "[entrypoint] Starting Paperclip worker"
        python3 "$INSTALL_DIR/supabase_paperclip_worker.py" > >(sed 's/^/[WORKER] /') 2> >(sed 's/^/[WORKER] /' >&2) &
        WORKER_PID=$!

        # Wait for either process to exit
        wait -n
        EXIT_CODE=$?

        # Kill the other processes
        if kill -0 $API_SERVER_PID 2>/dev/null; then
            echo "[entrypoint] Stopping API server"
            kill $API_SERVER_PID
        fi
        if kill -0 $TAIL_PID 2>/dev/null; then
            kill $TAIL_PID 2>/dev/null || true
        fi
        if kill -0 $WORKER_PID 2>/dev/null; then
            echo "[entrypoint] Stopping worker"
            kill $WORKER_PID
        fi

        exit $EXIT_CODE
        ;;
    *)
        exec hermes "$@"
        ;;
esac
