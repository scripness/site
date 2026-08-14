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
    assert body =~ "produce the implementation"
    assert body =~ "clear issues and correct plans"
    assert body =~ "acceptance criteria and a definition of done"
    assert body =~ "deterministic tools, layered tests"
    assert body =~ "automated and manual QA"
  end

  test "background summarizes professional breadth and working model", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="background")
    assert body =~ "More than a decade building full-stack products"
    assert body =~ "I define the work; agents implement it; tests and QA prove the result"
    assert body =~ "Mostly contract and remote"
    assert body =~ "across many teams, products, and codebases"
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
    assert body =~ "clear issues, acceptance criteria, deterministic feedback loops"
    assert body =~ "layered testing"
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
    assert body =~ "Frameworks"
    assert body =~ "Express/AdonisJS, Phoenix"
    assert body =~ "Terraform, CDK, OpenTofu, Ansible, Chef"
    assert body =~ "design systems, give agents the right work, build reliable feedback loops"
    assert body =~ "Microservices, monoliths, DDD"
    assert body =~ "State-machine, unit, integration, acceptance, smoke, BDD"
    assert body =~ "Gherkin, Jest, Cypress, Playwright, RSpec, Pest, and Cucumber"
  end

  test "how I work explains the coding-agent workflow in plain language", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="how-i-work")
    assert body =~ "Define the issue"
    assert body =~ "Check the plan"
    assert body =~ "Set the feedback loops"
    assert body =~ "Prove it works"
    assert body =~ "Get up to speed"
    assert body =~ "Deterministic rules, state machines, and feedback loops"
    assert body =~ "Automated checks and QA run first"
    assert body =~ "manually test the result"
    assert body =~ "understand unfamiliar systems"
    assert body =~ "without needing one familiar stack or domain"
  end

  test "links to GitHub and LinkedIn without hiding them on small screens", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(href="https://github.com/scripness")
    assert body =~ ~s(href="https://www.linkedin.com/in/andrei-scripcaru/")

    refute Regex.match?(~r/href="https:\/\/github\.com\/scripness"[^>]*class="[^"]*hidden/, body)

    refute Regex.match?(
             ~r/href="https:\/\/www\.linkedin\.com\/in\/andrei-scripcaru\/"[^>]*class="[^"]*hidden/,
             body
           )
  end

  test "shows Frederic Haddad's testimonial", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="testimonial")
    assert body =~ "Andrei is a one of a kind senior AI-powered developer"
    assert body =~ "past 20 years or so"
    assert body =~ "Frederic Haddad"
    assert body =~ "Head of Business Development · FinancialDocs"
  end

  test "ask me about section offers factual conversation starters", %{conn: conn} do
    body = conn |> get(~p"/") |> html_response(200)

    assert body =~ ~s(id="ask-me-about")
    assert body =~ "Working across many stacks"
    assert body =~ "80+ projects as a freelancer"
    assert body =~ "Legacy codebases"
    assert body =~ "Building with coding agents"
    assert body =~ "clear issues, correct plans, acceptance criteria"
    assert body =~ "Deterministic feedback loops and layered tests"
  end
end
