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

  test "publishes the current coding-agent responsibility accurately", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ "coding agents"
    assert body =~ "under my technical direction"
    assert body =~ "whole-change review, debugging, verification, and release readiness"
    assert body =~ "engineering accountability stays with me"
    assert body =~ "final merge"
  end

  test "background describes current work", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="background")
    assert body =~ "Cryptoli"
    assert body =~ "Independent project"
    assert body =~ "Mar 2026–Present"
    assert body =~ "Moldova"
  end

  test "Cryptoli project states verified product, workflow, stack, and operations", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="project-cryptoli")
    assert body =~ "cryptocurrency review and community platform"
    assert body =~ "authentication, community content, moderation, discovery, analytics"
    assert body =~ "isolated worktrees"
    assert body =~ "exact-head checks"
    assert body =~ "two whole-PR reviews"
    assert body =~ "human handoff and merge"
    assert body =~ "NestJS"
    assert body =~ "Next.js/React"
    assert body =~ "PostgreSQL"
    assert body =~ "Grafana/Alloy/Loki"
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
    assert body =~ "specification-driven delivery"
    assert body =~ "Playwright browser QA"
    assert body =~ "human-controlled merge"
  end

  test "how I work reflects Cryptoli's enforced lifecycle", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="how-i-work")
    assert body =~ "Ground scope and ownership"
    assert body =~ "Separate intent from evidence"
    assert body =~ "Direct the change, keep accountability"
    assert body =~ "Verify, review, then hand off"
    assert body =~ "operator-requested canonical issue"
    assert body =~ "fresh-context read-only review"
  end

  test "ask me about section offers factual conversation starters", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="ask-me-about")
    assert body =~ "Working across many stacks"
    assert body =~ "80+ projects as a freelancer"
    assert body =~ "Legacy codebases"
    assert body =~ "Accountable coding-agent delivery"
    assert body =~ "Cryptoli does not treat agent output as proof"
  end
end
