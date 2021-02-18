defmodule Min.URLsTest do
  use Min.DataCase

  import Min.URLs

  alias Min.URLs.URL

  describe "create/1" do
    test "inserts a valid url" do
      {:ok, %URL{} = url} = create("http://www.abc.com")

      assert "http://www.abc.com" == url.url
      assert is_binary(url.hash)
    end

    test "does not insert a valid url" do
      {:error, changeset} = create("hi")

      assert %{url: ["is invalid"]} == errors_on(changeset)
    end

    test "returns previously inserted url" do
      {:ok, %URL{} = url_1} = create("https://www.def.com")
      {:ok, %URL{} = url_2} = create("https://www.def.com")

      assert url_1 == url_2
    end
  end

  # describe "validate/1" do
  #   test "returns ok tuple for valid urls" do
  #     for url <- [
  #           "http://www.aol.com?query=hi",
  #           "https://www.abc.ninja?query=hi",
  #           "http://www.a.b/c/d"
  #         ] do
  #       assert {:ok, ^url} = validate(url)
  #     end
  #   end

  #   test "returns :error for invalid urls" do
  #     for url <- [
  #           "hello://www.abc.com",
  #           "https:/www.aol.com",
  #           "hi"
  #         ] do
  #       assert :error = validate(url)
  #     end
  #   end
  # end
end
