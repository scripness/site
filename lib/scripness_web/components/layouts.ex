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
    <div class="min-h-screen">
      <header class="px-5 pt-6 sm:px-8 sm:pt-8">
        <div class="mx-auto flex max-w-6xl flex-wrap items-center justify-between gap-5 border-b border-[#b9a58e] pb-6">
          <a href="/" class="text-[#30231a]">
            <div>
              <p class="font-serif text-xl font-semibold">Andrei Scripcaru</p>
              <p class="text-xs text-[#765d46]">Senior full-stack software engineer</p>
            </div>
          </a>
          <nav
            aria-label="Primary"
            class="flex w-full flex-wrap items-center justify-between gap-x-2 text-sm text-[#5d412d] sm:w-auto sm:justify-start sm:gap-x-5"
          >
            <a
              href="#projects"
              class="border-b border-transparent py-3 hover:border-[#8d6b50] sm:py-2"
            >
              Work
            </a>
            <a
              href="#how-i-work"
              class="hidden border-b border-transparent py-2 hover:border-[#8d6b50] sm:inline"
            >
              How I work
            </a>
            <a
              href="https://github.com/scripness"
              target="_blank"
              rel="noopener noreferrer"
              class="border-b border-transparent py-3 hover:border-[#8d6b50] sm:py-2"
            >
              GitHub
            </a>
            <a
              href="https://www.linkedin.com/in/andrei-scripcaru/"
              target="_blank"
              rel="noopener noreferrer"
              class="border-b border-transparent py-3 hover:border-[#8d6b50] sm:py-2"
            >
              LinkedIn
            </a>
            <a
              id="header-email"
              class="border-b border-transparent py-3 font-semibold hover:border-[#8d6b50] sm:py-2"
              href="mailto:mail@scripness.com"
            >
              Contact
            </a>
            <a
              class="border-b border-transparent py-3 font-semibold hover:border-[#8d6b50] sm:py-2"
              href="/assets/andrei-scripcaru-technical.pdf"
            >
              Résumé
            </a>
          </nav>
        </div>
      </header>

      <main class="px-5 pb-16 pt-14 sm:px-8 sm:pt-20">
        <div class="mx-auto max-w-6xl">
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
