defmodule Mix.Tasks.Resume.Build do
  use Mix.Task

  @shortdoc "Builds the résumé PDFs with Chromium"

  @chromium_names ~w(chromium chromium-browser google-chrome google-chrome-stable)
  @resume_marker ~s(<div class="resume">)

  @impl Mix.Task
  def run(_args) do
    chromium = find_chromium!()
    root = Mix.Project.project_file() |> Path.dirname() |> Path.expand()
    source_dir = Path.join(root, "priv/resume")
    output_dir = Path.join(root, "priv/static/assets")

    temporary_dir =
      Path.join(System.tmp_dir!(), "scripness-resume-#{System.unique_integer([:positive])}")

    File.mkdir_p!(temporary_dir)

    try do
      File.cp!(Path.join(source_dir, "resume.css"), Path.join(temporary_dir, "resume.css"))
      resume_html = File.read!(Path.join(source_dir, "resume.html"))

      variants = [
        {"andrei-scripcaru.pdf", resume_html},
        {"andrei-scripcaru-technical.pdf", variant_html(resume_html, "technical")},
        {"andrei-scripcaru-full.pdf", variant_html(resume_html, "full")}
      ]

      File.mkdir_p!(output_dir)

      Enum.each(variants, fn {output_name, html} ->
        html_path = Path.join(temporary_dir, Path.rootname(output_name) <> ".html")
        output_path = Path.join(output_dir, output_name)
        File.write!(html_path, html)
        print_pdf!(chromium, html_path, output_path)
      end)
    after
      File.rm_rf!(temporary_dir)
    end
  end

  @doc false
  def variant_html(html, variant) when variant in ["technical", "full"] do
    case String.split(html, @resume_marker, parts: 2) do
      [before_marker, after_marker] ->
        before_marker <> ~s(<div class="resume" data-variant="#{variant}">) <> after_marker

      [_html] ->
        raise ArgumentError, "résumé HTML does not contain #{@resume_marker}"
    end
  end

  defp find_chromium! do
    Enum.find_value(@chromium_names, &System.find_executable/1) ||
      Mix.raise(
        "Chromium is required to build résumé PDFs. Install one of: #{Enum.join(@chromium_names, ", ")}"
      )
  end

  defp print_pdf!(chromium, html_path, output_path) do
    args = [
      "--headless",
      "--no-sandbox",
      "--disable-dev-shm-usage",
      "--disable-gpu",
      "--virtual-time-budget=5000",
      "--no-pdf-header-footer",
      "--print-to-pdf=#{output_path}",
      file_url(html_path)
    ]

    case System.cmd(chromium, args, stderr_to_stdout: true) do
      {_message, 0} ->
        Mix.shell().info("Generated #{Path.relative_to_cwd(output_path)}")

      {message, status} ->
        Mix.raise(
          "Chromium failed to generate #{Path.basename(output_path)} (exit #{status}):\n#{message}"
        )
    end
  end

  defp file_url(path), do: URI.to_string(%URI{scheme: "file", path: Path.expand(path)})
end
