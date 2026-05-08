# Encore + Vue Dashboard Monorepo

A full-stack monorepo template with an [Encore](https://encore.dev) TypeScript backend and a [Vue](https://vuejs.org) + [Nuxt UI](https://ui.nuxt.com) dashboard, managed by [Turborepo](https://turbo.build).

## Stack

| Layer | Technology |
|---|---|
| Backend | Encore.ts |
| Dashboard | Vue 3 + Vite + Nuxt UI |
| Monorepo | Turborepo + npm workspaces |
| Shared code | TypeScript package (`@app/shared`) |

## Prerequisites

- [Node.js](https://nodejs.org) 20+
- [Encore CLI](https://encore.dev/docs/ts/install) — install and login with `encore auth login`
- If using this as a template, run `encore app init` in `apps/backend` to register your app and update the `id` in `encore.app`

## Recommended Claude Skills

Enhance your development experience with these Claude skills:

```bash
npx add-skill encoredev/skills
npx skills add vuejs-ai/skills
npx skills add nuxt/ui
```

These skills provide specialized assistance for Encore, Vue.js, and Nuxt UI development.

## Getting Started

```bash
npm install
npm run dev
```

This starts both apps:

- **Backend** — http://127.0.0.1:4000
- **Dashboard** — http://localhost:5173

## Project Structure

```
apps/
├── backend/        @app/backend — Encore TS API
└── dashboard/      @app/dashboard — Vue + Vite SPA
packages/
└── shared/         @app/shared — shared types and utilities
```

## Commands

| Command | Description |
|---|---|
| `npm run dev` | Start all apps in dev mode |
| `npm run build` | Build all packages |
| `npm run lint` | Lint all packages |
| `npm run typecheck` | Type-check all packages |

### Run a single app

```bash
npx turbo run dev --filter=@app/backend
npx turbo run dev --filter=@app/dashboard
```

## Shared Package

Add shared types and utilities in `packages/shared/src/index.ts`:

```ts
import { User } from "@app/shared"
```

The shared package is automatically compiled before the backend or dashboard runs.

## Deployment

When deploying to Encore Cloud:

1. Set the root directory in app settings to `apps/backend` (Settings > General > Root Directory)
2. The prebuild hook in `encore.app` automatically builds shared packages before deployment

## Detailed Docs

See [`docs/turborepo.md`](docs/turborepo.md) for configuration details and troubleshooting.
