# Project guidance

This is Andrei Scripcaru's Phoenix 1.8 and Tailwind CSS v4 personal site. The repository
also owns the editable résumé sources and generates the PDFs published by the site.

## Source-of-truth hierarchy

1. `priv/resume/resume.html` is authoritative for English career facts, résumé wording,
   and the plain, Technical, and Full variants.
2. `priv/resume/resume-cnpf.html` is authoritative for the Romanian CNPF variant.
3. `priv/resume/resume.css` is authoritative for résumé layout and print styling.
4. `priv/static/assets/andrei-scripcaru-technical.pdf` is the generated canonical public
   résumé. All PDFs are generated artifacts; never edit them manually.
5. `lib/scripness_web/controllers/page_html/home.html.heex` is authoritative for website
   presentation. Claims about Andrei's career must be supported by the résumé sources.

For a career-content change, update the relevant résumé HTML first, run
`mix resume.build`, and then align the homepage. This repository is the only maintained
source; do not create or maintain a separate résumé repository.

## Required workflows

- Build all four résumé PDFs with `mix resume.build`. Chromium is required.
- Run `mix precommit` after changes and fix all failures.
- Pushes to GitHub `main` deploy through `.github/workflows/deploy.yml`; production uses
  `scripness.com`. Manual deployments use `fly deploy`.
- Use `Req` for HTTP calls. Do not add `:httpoison`, `:tesla`, or `:httpc`.

## Site constraints

- Keep the homepage in `lib/scripness_web/controllers/page_html/home.html.heex`.
- Keep its section order: Hero, Background, Projects, Technical Profile, How I work,
  Ask me about.
- Preserve the cozy visual tone: warm gradients, soft shadows, serif headings, calm
  spacing, subtle hover transitions, and readable mobile layouts.
- Keep the Tailwind v4 imports in `assets/css/app.css`; do not use `@apply` or DaisyUI.
- Do not add raw inline scripts to HEEx. Import browser dependencies through `app.js`.
- Use `<.icon>` for icons and Phoenix components such as `<.input>` and `<.form>` when
  applicable. Give key interactive elements stable, unique DOM IDs.
- Use HEEx (`~H` or `.html.heex`), `{...}` attribute interpolation, HEEx comments, and
  `<%= for ... do %>` rather than `Enum.each` in templates.
- Use current LiveView navigation APIs (`<.link navigate>`, `<.link patch>`,
  `push_navigate`, and `push_patch`) rather than deprecated redirect helpers.

## Testing

- Prefer focused outcome assertions and stable element IDs over raw HTML comparisons.
- Use `start_supervised!/1` for supervised test processes.
- Avoid `Process.sleep/1`; synchronize with monitors or `_ = :sys.get_state/1`.
