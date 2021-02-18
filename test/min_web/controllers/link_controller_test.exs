defmodule MinWeb.LinkControllerTest do
  use MinWeb.ConnCase

  alias Min.Links

  describe "GET /:hash" do
    test "redirects externally if url exists", %{conn: conn} do
      {:ok, url} = Links.create("https://www.google.com")

      assert "https://www.google.com" ==
               conn
               |> get("/#{url.hash}")
               |> redirected_to(302)
    end

    test "redirects internally else", %{conn: conn} do
      assert "/" ==
               conn
               |> get("/abc123")
               |> redirected_to(302)
    end
  end

  describe "POST /api/links" do
    test "returns url on success", %{conn: conn} do
      expected_url = Routes.link_url(@endpoint, :show, "331e5b6b")

      assert %{"url" => expected_url} ==
               conn
               |> post("/api/links", %{url: "https://www.google.com"})
               |> json_response(200)
    end

    test "returns error", %{conn: conn} do
      assert %{"error" => "Invalid URL"} ==
               conn
               |> post("/api/links", %{url: "www.google"})
               |> json_response(400)
    end
  end
end
