# Turborepo Integration

This project is a monorepo managed with **Turborepo** and **npm workspaces**.

## Project Structure

```
my-app/
├── package.json              ← Root workspace config
├── turbo.json                ← Turborepo pipeline
├── package-lock.json
├── .gitignore
├── docs/
├── apps/
│   ├── backend/              ← @app/backend (Encore TS)
│   │   ├── encore.app
│   │   └── package.json
│   └── dashboard/            ← @app/dashboard (Vue + Vite)
│       ├── vite.config.ts
│       └── package.json
└── packages/
    └── shared/               ← @app/shared (shared types/utilities)
        ├── src/index.ts
        └── tsconfig.json
```

## Getting Started

```bash
npm install
npm run dev
```

Both backend (http://127.0.0.1:4000) and dashboard (http://localhost:5173) start together.

## Commands

| Command | Description |
|---|---|
| `npm run dev` | Run all apps in dev mode |
| `npm run build` | Build all packages |
| `npm run lint` | Lint all packages |
| `npm run typecheck` | Type-check all packages |

### Run a single app

```bash
npx turbo run dev --filter=@app/backend
npx turbo run dev --filter=@app/dashboard
```

## Shared Package (`@app/shared`)

Add shared types, interfaces, and utilities in `packages/shared/src/index.ts`.

```ts
import { User } from "@app/shared"
```

The shared package is automatically compiled before the backend or dashboard runs. This is configured in `turbo.json` via:

- `@app/backend#dev` depends on `@app/shared#build`
- `build` task uses `dependsOn: ["^build"]` (builds all workspace dependencies first)

## Configuration Files

### Root `package.json`

Defines npm workspaces and turbo as a dev dependency.

```json
{
  "workspaces": ["apps/*", "packages/*"]
}
```

### `turbo.json`

Pipeline configuration with `envMode: "loose"` for Volta compatibility.

Key task: `@app/backend#dev` depends on `@app/shared#build` so the shared package is compiled before Encore starts.

### `apps/backend/encore.app`

Contains a prebuild hook for deployment:

```json
{
  "build": {
    "hooks": {
      "prebuild": "npx turbo build --filter=@app/backend^..."
    }
  }
}
```

This runs when deploying via Encore Cloud or exporting a Docker image. The `^...` filter builds only the backend's dependencies (not the backend itself).

## Deployment

When deploying to Encore Cloud:

1. Set the root directory in app settings to `apps/backend` (Settings > General > Root Directory)
2. The prebuild hook in `encore.app` automatically builds shared packages before deployment

## Notes

- The `id` in `encore.app` is your registered Encore Cloud app identifier. When using this repo as a template, run `encore app init` in `apps/backend` to register your app and update the `id` field.
- Encore CLI is a Go binary installed globally at `~/.encore/bin/encore`, not via npm
- `envMode: "loose"` in turbo.json is required when using Volta on Windows to pass environment variables through to child processes
- The shared package outputs to `dist/` which is excluded from git
