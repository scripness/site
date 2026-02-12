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
end
