# Andrei Scripcaru — personal site and résumé

This repository contains Andrei Scripcaru's Phoenix website and the sources used to
generate his résumé PDFs. It is the single repository for both published surfaces.

## Sources of truth

Career facts and résumé wording originate in:

- `priv/resume/resume.html` for the English résumé and all its variants
- `priv/resume/resume.css` for résumé presentation and print layout

The PDFs in `priv/static/assets/` are generated artifacts. Never edit them manually.
The Technical PDF is the canonical public résumé linked from the website.

The homepage is maintained in
`lib/scripness_web/controllers/page_html/home.html.heex`. It is the source of truth for
the website's presentation, but every factual claim about Andrei's work must remain
supported by the résumé sources. When career information changes, update the résumé
source first, regenerate the PDFs, and then align the homepage.

## Stack

- Phoenix 1.8
- Tailwind CSS v4 (no `tailwind.config.js`)
- Deploys to Fly.io with a release-based Docker image

## Key locations

- Homepage content: `lib/scripness_web/controllers/page_html/home.html.heex`
- Layout shell: `lib/scripness_web/components/layouts.ex`
- Styles: `assets/css/app.css`
- Résumé sources: `priv/resume/resume.html` and `priv/resume/resume.css`
- Canonical résumé asset: `priv/static/assets/andrei-scripcaru-technical.pdf`

## Building the résumé PDFs

Edit the HTML and CSS in `priv/resume/`, then run:

```sh
mix resume.build
```

Chromium must be installed as `chromium`, `chromium-browser`, `google-chrome`, or
`google-chrome-stable`. The task generates these three A4 PDFs in `priv/static/assets/`:

- `andrei-scripcaru.pdf` (plain)
- `andrei-scripcaru-technical.pdf` (canonical Technical résumé)
- `andrei-scripcaru-full.pdf`

## Local development

1. `mix setup`
2. `mix phx.server`
3. Visit `http://localhost:4000`

## Testing & linting

Run `mix precommit` before shipping changes.

## Deploying to Fly.io

Pushes to `main` deploy the `scripness` app through
`.github/workflows/deploy.yml`. The GitHub repository must have an app-scoped
`FLY_API_TOKEN` Actions secret.

For a manual deployment from an authenticated workstation, run `fly deploy`.

The app auto-stops when idle and auto-starts on request (`auto_stop_machines = 'stop'`). Set `min_machines_running = 1` in `fly.toml` to avoid cold starts.
