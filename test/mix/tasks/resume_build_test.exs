defmodule Mix.Tasks.Resume.BuildTest do
  use ExUnit.Case, async: true

  alias Mix.Tasks.Resume.Build

  @html "before<div class=\"resume\">after<div class=\"resume\">untouched"

  test "adds the technical variant to only the first resume container" do
    assert Build.variant_html(@html, "technical") ==
             "before<div class=\"resume\" data-variant=\"technical\">after<div class=\"resume\">untouched"
  end

  test "adds the full variant" do
    assert Build.variant_html(@html, "full") =~
             ~s(<div class="resume" data-variant="full">)
  end

  test "raises when the resume container is absent" do
    assert_raise ArgumentError, ~r/does not contain/, fn ->
      Build.variant_html("<html></html>", "technical")
    end
  end
end
