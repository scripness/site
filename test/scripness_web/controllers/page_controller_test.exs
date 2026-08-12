defmodule ScripnessWeb.PageControllerTest do
  use ScripnessWeb.ConnCase

  test "renders the warm personal introduction and contact paths", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="introduction")
    assert body =~ "I design software and guide the work from idea to release."
    assert body =~ "Senior full-stack software engineer"
    assert body =~ ~s(id="email-andrei")
    assert body =~ ~s(href="mailto:mail@scripness.com")
    assert body =~ ~s(href="/assets/andrei-scripcaru-technical.pdf")
    assert body =~ ~s(href="tel:+37378181261")
  end

  test "explains how Andrei builds with coding agents", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ "coding agents"
    assert body =~ "agents to produce the implementation"
    assert body =~ "guide the technical work"
    assert body =~ "review the result, solve problems, test the system"
    assert body =~ "I still own the engineering work"
  end

  test "background summarizes professional breadth and working model", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="background")
    assert body =~ "More than a decade building full-stack products"
    assert body =~ "Coding agents produce the implementation; I guide and check the work"
    assert body =~ "Moldova"
  end

  test "Cryptoli shows the full-stack and coding-agent experience used on the project", %{
    conn: conn
  } do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="project-cryptoli")
    assert body =~ "Latest project"
    assert body =~ "Cryptocurrency review and community platform"
    assert body =~ "admin tools, community"
    assert body =~ "moderation, search, notifications, analytics"
    assert body =~ "practical experience using coding agents"
    assert body =~ "planning and system design through"
    assert body =~ "NestJS"
    assert body =~ "Next.js/React"
    assert body =~ "PostgreSQL"
  end

  test "selected and earlier work remains grounded in the resume", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    for company <- [
          "FinancialDocs",
          "NIXAP",
          "Dispatch42",
          "Travod",
          "Rio",
          "Crawless",
          "Deditech Com",
          "eToro",
          "MKM",
          "GoodLeap",
          "RentInsider",
          "Virail",
          "Deutsche Fintech Solutions",
          "Independent Freelancing"
        ] do
      assert body =~ company
    end

    assert body =~ "2,000+ service classes"
    assert body =~ "80+ CRM, SaaS, and e-commerce projects"
  end

  test "each project disclosure has accurate open and closed labels", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert length(Regex.scan(~r/group-open:hidden/, body)) == 5
    assert length(Regex.scan(~r/group-open:inline/, body)) == 5
  end

  test "technical profile frames stack knowledge as engineering judgment", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="technical-profile")
    assert body =~ "Technical Profile"
    assert body =~ "Programming"
    assert body =~ "TypeScript, JavaScript, PHP, Ruby, Python, Kotlin, Go, C#, Elixir, Delphi"
    assert body =~ "design systems, guide agents, review their work, find problems"
    assert body =~ "clear specifications, coding agents, code review"
    assert body =~ "automated tests, browser testing, releases"
  end

  test "how I work explains the coding-agent workflow in plain language", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="how-i-work")
    assert body =~ "Understand the problem"
    assert body =~ "Plan the system"
    assert body =~ "Guide the agents"
    assert body =~ "Review and test"
    assert body =~ "I find the cause and make sure it is fixed properly"
    assert body =~ "I decide when the result is ready to release"
  end

  test "ask me about section offers factual conversation starters", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="ask-me-about")
    assert body =~ "Working across many stacks"
    assert body =~ "80+ projects as a freelancer"
    assert body =~ "Legacy codebases"
    assert body =~ "Building with coding agents"
    assert body =~ "remain responsible for the result"
  end
end
