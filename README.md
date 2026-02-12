# Scripness Site

Personal website for Andrei Scripcaru (Phoenix + Tailwind).

## Local development

1. `mix setup`
2. `mix phx.server`
3. Visit `http://localhost:4000`

## Deploying to Fly.io

The app is deployed as a Phoenix release.

1. `fly launch` (first time)
2. `fly deploy`

Set env vars as needed:

```
fly secrets set SECRET_KEY_BASE="$(mix phx.gen.secret)"
```
