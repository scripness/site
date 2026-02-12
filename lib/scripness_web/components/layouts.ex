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
            <div class="h-10 w-10 rounded-full border border-white/30 bg-white/10"></div>
            <div>
              <p class="text-sm uppercase tracking-[0.3em]">Andrei Scripcaru</p>
              <p class="text-xs text-white/70">Staff-level full-stack engineer</p>
            </div>
          </div>
          <div class="flex items-center gap-3 text-sm text-white/80">
            <a
              class="rounded-full border border-white/40 px-4 py-2 transition hover:border-white hover:text-white"
              href="mailto:mail@scripness.com"
            >
              mail@scripness.com
            </a>
            <a
              class="rounded-full bg-white px-4 py-2 text-[#1a0f09] transition hover:-translate-y-0.5 hover:shadow-lg"
              href="/assets/Andrei%20Scripcaru%20-%20Technical.pdf"
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
