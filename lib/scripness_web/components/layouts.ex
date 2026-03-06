defmodule ScripnessWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use ScripnessWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="relative min-h-screen overflow-hidden">
      <div
        class="pointer-events-none absolute inset-0 opacity-60"
        style="background-image: radial-gradient(circle at 30% 20%, rgba(255, 255, 255, 0.35), transparent 55%), radial-gradient(circle at 70% 70%, rgba(255, 233, 214, 0.4), transparent 60%);"
      >
      </div>
      <div class="pointer-events-none absolute inset-0 bg-[#1a0f09]/35"></div>
      <div class="pointer-events-none absolute -right-32 top-24 h-72 w-72 rounded-full bg-amber-200/40 blur-[120px]">
      </div>
      <div class="pointer-events-none absolute left-12 top-1/3 h-80 w-80 rounded-full bg-rose-200/40 blur-[140px]">
      </div>

      <header class="relative z-10 px-6 pt-8 sm:px-10 lg:px-16">
        <div class="flex flex-wrap items-center justify-between gap-4">
          <div class="flex items-center gap-3 text-white/90">
            <img
              src={~p"/images/sigil.svg"}
              alt=""
              class="h-10 w-10 rounded-full border border-white/30 bg-white/10 p-1"
            />
            <div>
              <p class="text-sm uppercase tracking-[0.3em]">Andrei Scripcaru</p>
              <p class="text-xs text-white/70">Full-stack software engineer</p>
            </div>
          </div>
          <div class="flex items-center gap-3 text-sm text-white/80">
            <a
              href="https://github.com/scripness"
              target="_blank"
              rel="noopener noreferrer"
              class="rounded-full border border-white/40 p-2 transition hover:border-white hover:text-white"
              aria-label="GitHub"
            >
              <svg viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z" />
              </svg>
            </a>
            <a
              href="https://www.linkedin.com/in/andrei-scripcaru/"
              target="_blank"
              rel="noopener noreferrer"
              class="rounded-full border border-white/40 p-2 transition hover:border-white hover:text-white"
              aria-label="LinkedIn"
            >
              <svg viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016a5.54 5.54 0 01.016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225h2.4z" />
              </svg>
            </a>
            <a
              class="rounded-full border border-white/40 px-4 py-2 transition hover:border-white hover:text-white"
              href="mailto:mail@scripness.com"
            >
              mail@scripness.com
            </a>
            <a
              class="rounded-full bg-white px-4 py-2 text-[#1a0f09] transition hover:-translate-y-0.5 hover:shadow-lg"
              href="/assets/andrei-scripcaru-technical.pdf"
            >
              Download resume
            </a>
          </div>
        </div>
      </header>

      <main class="relative z-10 px-6 pb-24 pt-16 sm:px-10 lg:px-16">
        <div class="mx-auto max-w-5xl space-y-16">
          {render_slot(@inner_block)}
        </div>
      </main>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end
end
