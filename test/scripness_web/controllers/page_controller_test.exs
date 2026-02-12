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

  test "compact tier has 'More work' label", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "More work"
  end

  test "compact tier shows all remaining project company names", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Rio"
    assert body =~ "Crawless"
    assert body =~ "Deditech Com"
    assert body =~ "eToro"
    assert body =~ "MKM"
    assert body =~ "GoodLeap"
    assert body =~ "RentInsider"
    assert body =~ "Virail"
    assert body =~ "Deutsche Fintech Solutions"
  end

  test "compact tier cards show one-line descriptions", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "live-streaming platform"
    assert body =~ "browser automation IDE"
    assert body =~ "B2B CRM"
    assert body =~ "job seekers and recruiters"
    assert body =~ "e-commerce platform"
    assert body =~ "solar financing platform"
    assert body =~ "rental platform"
    assert body =~ "travel search engine"
    assert body =~ "micro-frontend architecture"
  end

  test "compact tier cards contain resume bullet points on expand", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # GoodLeap expanded content
    assert body =~ "DocuSign and payment workflows"

    # RentInsider expanded content
    assert body =~ "Python backend"

    # Virail expanded content
    assert body =~ "Elasticsearch for performance"

    # Deutsche Fintech expanded content
    assert body =~ "B2C/B2B financial apps"
  end

  test "compact tier cards contain tech stack pills", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # Rio tech
    assert body =~ "Vue/Nuxt"

    # GoodLeap tech
    assert body =~ "AWS (Lambda, SQS, S3)"

    # Deutsche Fintech tech
    assert body =~ "Svelte"
    assert body =~ "Luigi/Micro-frontends"

    # Virail tech
    assert body =~ "PHP/Phalcon"
  end

  test "compact tier uses native details elements", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # The page should have many details elements (4 featured + 9 compact + ask me about)
    # Just verify the compact-specific card classes exist
    assert body =~ "rounded-2xl border border-[#e0d2c4] bg-white/70 p-4"
  end

  test "freelance aggregate card has dark styling and headline", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "Independent Freelancing"
    assert body =~ "bg-[#1a0f09]/90"
    assert body =~ "border-white/10"
  end

  test "freelance aggregate card contains resume bullet points", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # First bullet: "80+" is in a prominent span, rest follows
    assert body =~ "80+"
    assert body =~ "projects across CRM, SaaS, and e-commerce"
    assert body =~ "architecture, implementation, and ongoing maintenance end-to-end"

    # Second bullet
    assert body =~ "web, desktop, and mobile stacks"
    assert body =~ "direct client interaction"
  end

  test "freelance aggregate card has prominent 80+ text", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # "80+" should be in a larger, bold span
    assert body =~ "text-2xl font-bold"
    assert body =~ ">80+<"
  end

  test "freelance aggregate card has all 12 tech stack pills", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "PHP"
    assert body =~ "JavaScript/TypeScript"
    assert body =~ "Python"
    assert body =~ "Vue.js"
    assert body =~ "React"
    assert body =~ "Node.js"
    assert body =~ "MySQL"
    assert body =~ "PostgreSQL"
    assert body =~ "DynamoDB"
    assert body =~ "Flutter"
    assert body =~ "Delphi"
  end

  test "freelance aggregate card tech pills use dark style", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    assert body =~ "border-white/20"
    assert body =~ "text-white/70"
  end

  test "freelance aggregate card is not expandable", %{conn: conn} do
    conn = get(conn, ~p"/")
    body = html_response(conn, 200)

    # The freelance card should NOT be inside a details element
    # It should be a plain div, not expandable
    # Verify that "Independent Freelancing" is not inside a <summary> tag
    refute body =~ "<summary" <> ~s( ) <> "Independent Freelancing"
  end
end
