import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { asBoolean } from "@paperclipai/adapter-utils/server-utils";

type PreparedOpenCodeRuntimeConfig = {
  env: Record<string, string>;
  notes: string[];
  cleanup: () => Promise<void>;
};

function resolveXdgConfigHome(env: Record<string, string>): string {
  return (
    (typeof env.XDG_CONFIG_HOME === "string" && env.XDG_CONFIG_HOME.trim()) ||
    (typeof process.env.XDG_CONFIG_HOME === "string" && process.env.XDG_CONFIG_HOME.trim()) ||
    path.join(os.homedir(), ".config")
  );
}

function isPlainObject(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

async function readJsonObject(filepath: string): Promise<Record<string, unknown>> {
  try {
    const raw = await fs.readFile(filepath, "utf8");
    const parsed = JSON.parse(raw);
    return isPlainObject(parsed) ? parsed : {};
  } catch {
    return {};
  }
}

export async function prepareOpenCodeRuntimeConfig(input: {
  env: Record<string, string>;
  config: Record<string, unknown>;
}): Promise<PreparedOpenCodeRuntimeConfig> {
  const skipPermissions = asBoolean(input.config.dangerouslySkipPermissions, true);
  if (!skipPermissions) {
    return {
      env: input.env,
      notes: [],
      cleanup: async () => {},
    };
  }

  const sourceConfigDir = path.join(resolveXdgConfigHome(input.env), "opencode");
  const runtimeConfigHome = await fs.mkdtemp(path.join(os.tmpdir(), "paperclip-opencode-config-"));
  const runtimeConfigDir = path.join(runtimeConfigHome, "opencode");
  const runtimeConfigPath = path.join(runtimeConfigDir, "opencode.json");

  await fs.mkdir(runtimeConfigDir, { recursive: true });
  try {
    // Copy source config but exclude node_modules to avoid copying
    // large dependency trees that can cause ENOTEMPTY on cleanup
    // (e.g. zod/v4/locales symlinks held open by the adapter process)
    const entries = await fs.readdir(sourceConfigDir, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.name === "node_modules") continue;
      const src = path.join(sourceConfigDir, entry.name);
      const dest = path.join(runtimeConfigDir, entry.name);
      await fs.cp(src, dest, {
        recursive: true,
        force: true,
        errorOnExist: false,
        dereference: false,
      });
    }
  } catch (err) {
    if ((err as NodeJS.ErrnoException | null)?.code !== "ENOENT") {
      throw err;
    }
  }

  const existingConfig = await readJsonObject(runtimeConfigPath);
  const existingPermission = isPlainObject(existingConfig.permission)
    ? existingConfig.permission
    : {};
  const nextConfig = {
    ...existingConfig,
    permission: {
      ...existingPermission,
      external_directory: "allow",
    },
  };
  await fs.writeFile(runtimeConfigPath, `${JSON.stringify(nextConfig, null, 2)}\n`, "utf8");

  return {
    env: {
      ...input.env,
      XDG_CONFIG_HOME: runtimeConfigHome,
    },
    notes: [
      "Injected runtime OpenCode config with permission.external_directory=allow to avoid headless approval prompts.",
    ],
    cleanup: async () => {
      // Use maxRetries to handle race conditions with file locks
      // and ENOTEMPTY errors that can occur with nested symlinks
      let lastError: Error | undefined;
      for (let attempt = 0; attempt < 3; attempt++) {
        try {
          await fs.rm(runtimeConfigHome, { recursive: true, force: true, maxRetries: 3 });
          return;
        } catch (err) {
          lastError = err as Error;
          // Wait a bit before retrying to allow file handles to close
          await new Promise((resolve) => setTimeout(resolve, 50 * (attempt + 1)));
        }
      }
      // Log but don't throw - cleanup failures shouldn't crash the agent
      console.warn(`[opencode-local] Cleanup failed for ${runtimeConfigHome}: ${lastError?.message ?? lastError}`);
    },
  };
}
