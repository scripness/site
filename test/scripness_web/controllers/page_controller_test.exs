defmodule ScripnessWeb.PageControllerTest do
  use ScripnessWeb.ConnCase

  test "renders the warm personal introduction and contact paths", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="introduction")
    assert body =~ "I design software systems and direct the work that brings them to life."
    assert body =~ "Senior full-stack software engineer"
    assert body =~ ~s(id="email-andrei")
    assert body =~ ~s(href="mailto:mail@scripness.com")
    assert body =~ ~s(href="/assets/andrei-scripcaru-technical.pdf")
    assert body =~ ~s(href="tel:+37378181261")
  end

  test "publishes the coding-agent responsibility accurately", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ "coding agents"
    assert body =~ "agents for implementation"
    assert body =~ "technical direction, review, debugging, verification, and release readiness"
    assert body =~ "engineering accountability stays with me"
    assert body =~ "Release readiness remains a human engineering decision"
  end

  test "background summarizes professional breadth and working model", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="background")
    assert body =~ "More than a decade across product architecture and full-stack delivery"
    assert body =~ "Agent-produced implementation with human engineering accountability"
    assert body =~ "Moldova"
  end

  test "Cryptoli is presented as a selected project with its product and technical scope", %{
    conn: conn
  } do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="project-cryptoli")
    assert body =~ "cryptocurrency review and community platform"
    assert body =~ "community content, moderation, discovery, notifications, analytics"
    assert body =~ "agent-directed delivery"
    assert body =~ "automated verification"
    assert body =~ "production operations"
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

  test "each selected project disclosure has accurate open and closed labels", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert length(Regex.scan(~r/group-open:hidden/, body)) == 4
    assert length(Regex.scan(~r/group-open:inline/, body)) == 4
  end

  test "technical profile frames stack knowledge as engineering judgment", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="technical-profile")
    assert body =~ "Technical Profile"
    assert body =~ "Programming"
    assert body =~ "TypeScript, JavaScript, PHP, Ruby, Python, Kotlin, Go, C#, Elixir, Delphi"
    assert body =~ "architecture, constraints, review, debugging, and verification"
    assert body =~ "specification-led agent delivery"
    assert body =~ "browser QA"
    assert body =~ "release control"
  end

  test "how I work explains accountable agent-directed engineering", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="how-i-work")
    assert body =~ "Define the intended outcome"
    assert body =~ "Shape the system"
    assert body =~ "Direct the change, keep accountability"
    assert body =~ "Prove the result"
    assert body =~ "architecture and boundaries with the whole product in mind"
    assert body =~ "accountability for the resulting system remains with me"
  end

  test "ask me about section offers factual conversation starters", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="ask-me-about")
    assert body =~ "Working across many stacks"
    assert body =~ "80+ projects as a freelancer"
    assert body =~ "Legacy codebases"
    assert body =~ "Engineering with coding agents"
    assert body =~ "reviewed and verified as engineering work"
  end
end
