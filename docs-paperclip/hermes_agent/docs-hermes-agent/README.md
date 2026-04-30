# Hermes Agent Documentation

Organized documentation for Hermes Agent.

## Structure

- **guides/** — How-to guides and tutorials
  - `MEMORY_SYSTEM_GUIDE.md` — Persistent memory setup, configuration, and best practices
  - `PROFILES_GUIDE.md` — Agent profiles, switching UI, and Paperclip integration
  - `PROFILES_PAPERCLIP_INTEGRATION.md` — Detailed profile architecture and org chart mapping
  - `PROMPTING_GUIDE.md` — All ways to send prompts to Hermes (CLI, Python API, REST API)
  - `INTEGRATION_GUIDE_CLINE_TASKS.md` — Using Hermes via Cline tasks with examples
  - `CLINE_INTEGRATION_GUIDE.md` — Cline-specific integration patterns and workflow

- **releases/** — Release notes
  - `RELEASE_v0.2.0.md`
  - `RELEASE_v0.3.0.md`
  - `RELEASE_v0.4.0.md`
  - `RELEASE_v0.5.0.md`
  - `RELEASE_v0.6.0.md` (current)

- **project/** — Project documentation
  - `README.md` — Project overview
  - `AGENTS.md` — Agent configuration
  - `CONTRIBUTING.md` — Contribution guidelines

- **setup-submodule.sh** — Script to add Hermes as a git submodule to any repo
- **.clinerules-template** — Template `.clinerules` for submodule repos

## Quick Start

```bash
cd /Users/_Hermes/hermes-agent
source venv/bin/activate
bash run.sh "your task"
```

## Adding Hermes as a Submodule to Any Repo

1. Clone the target repo:
   ```bash
   git clone https://github.com/Construct-AI-primary/your-repo.git
   cd your-repo
   ```

2. Run the setup script:
   ```bash
   bash /Users/_Hermes/hermes-agent/docs-hermes-agent/setup-submodule.sh
   ```

   Or manually:
   ```bash
   git submodule add https://github.com/tennantalistair/hermes-agent.git hermes_agent
   git submodule update --init --recursive
   ```

3. Configure `.clinerules` (the script does this automatically, or use `.clinerules-template`)

4. Set up:
   ```bash
   cd hermes_agent
   cp .env.example .env
   # Edit .env: uncomment OPENROUTER_API_KEY and add your key
   python3 -m venv venv
   source venv/bin/activate
   pip install -e .
   ```

5. Test:
   ```bash
   ./run.sh hello
   # or: hermes run hello (if .clinerules is configured in your IDE)
   ```

## Target Repos

Apply to:
- `construct_ai`
- `construct_ai_docs`
- `paperclip_render`
- `openclaw`
- `construct_ai-mobile`

Each repo gets:
- `hermes_agent/` — the submodule
- `.clinerules` — auto-rules for Cline
- One shared API key in `hermes_agent/.env`