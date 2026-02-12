# Scripness Site

Personal website for Andrei Scripcaru (Phoenix + Tailwind). The homepage is crafted to make the work legible for hiring managers with proof blocks, fit notes, and a clear resume download.

## Stack

- Phoenix 1.8
- Tailwind CSS v4 (no `tailwind.config.js`)
- Deploys to Fly.io with a release-based Docker image

## Key locations

- Homepage content: `lib/scripness_web/controllers/page_html/home.html.heex`
- Layout shell: `lib/scripness_web/components/layouts.ex`
- Styles: `assets/css/app.css`
- Resume asset: `priv/static/assets/Andrei Scripcaru - Technical.pdf`

## Local development

1. `mix setup`
2. `mix phx.server`
3. Visit `http://localhost:4000`

## Testing & linting

Run `mix precommit` before shipping changes.

## Deploying to Fly.io

1. `fly launch` (first time)
2. `fly secrets set SECRET_KEY_BASE="$(mix phx.gen.secret)"`
3. `fly secrets set PHX_HOST="scripness.fly.dev"`
4. `fly deploy`
