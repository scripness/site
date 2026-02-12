defmodule ScripnessWeb.PageControllerTest do
  use ScripnessWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Andrei Scripcaru"
  end

  test "header contains name and subtitle", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Andrei Scripcaru"
    assert body =~ "Full-stack software engineer"
    refute body =~ "Staff-level"
  end

  test "header contains email and resume links", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ ~s(href="mailto:mail@scripness.com")
    assert body =~ "mail@scripness.com"
    assert body =~ ~s(href="/assets/Andrei%20Scripcaru%20-%20Technical.pdf")
    assert body =~ "Download resume"
  end

  test "hero section has resume-grounded content", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # Uppercase label reflects contract/freelance nature
    assert body =~ "Full-stack engineering, contract"
    assert body =~ "freelance"

    # Headline is factual, derived from resume summary
    assert body =~ "13 years designing and delivering complete systems"
    refute body =~ "make the real work visible"

    # Description mentions key resume facts
    assert body =~ "80+"
    assert body =~ "contract and freelance"
    assert body =~ "full stack"

    # Skill tags reflect resume content
    assert body =~ "End-to-End Delivery"
    assert body =~ "Agentic Development"
    assert body =~ "10+ languages"
    refute body =~ "AI-accelerated teams"
    refute body =~ "System architecture"
  end

  test "hero CTA buttons link to email and resume", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Email me"
    assert body =~ "Resume (PDF)"
    assert body =~ ~s(href="mailto:mail@scripness.com")
    assert body =~ ~s(href="/assets/Andrei%20Scripcaru%20-%20Technical.pdf")
    refute body =~ "Start a conversation"
  end

  test "projects section has factual heading and engagement count", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Projects"
    assert body =~ "14 engagements"
    refute body =~ "Proof of impact"
  end

  test "featured project cards present for FinancialDocs, NIXAP, Dispatch42, Travod", %{
    conn: conn
  } do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "FinancialDocs"
    assert body =~ "NIXAP"
    assert body =~ "Dispatch42"
    assert body =~ "Travod"
  end

  test "featured project cards show role titles from resume", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Full-Stack Engineer"
    assert body =~ "Full-Stack Developer"
    assert body =~ "Contract"
    assert body =~ "Full-Time"
  end

  test "featured project cards contain resume bullet points", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # FinancialDocs bullets
    assert body =~ "2,000+ service classes"
    assert body =~ "legaldocs.com"
    assert body =~ "webhook-based caching system"

    # NIXAP bullets
    assert body =~ "multi-tenant VoIP system"

    # Dispatch42 bullets
    assert body =~ "serverless notifications system"

    # Travod bullets
    assert body =~ "Traduno"
    assert body =~ "GraphQL API layer"
  end

  test "featured project cards contain tech stack pills", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # FinancialDocs tech
    assert body =~ "PayloadCMS"
    assert body =~ "MongoDB"

    # NIXAP tech
    assert body =~ "Electron"
    assert body =~ "RabbitMQ"

    # Dispatch42 tech
    assert body =~ "Kotlin"
    assert body =~ "AWS"

    # Travod tech
    assert body =~ "Ruby/Rails"
    assert body =~ "RSpec"
  end

  test "featured project cards use native details elements", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # Verify details/summary elements are used
    assert body =~ "<details"
    assert body =~ "<summary"
  end
end
