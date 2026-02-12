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
end
