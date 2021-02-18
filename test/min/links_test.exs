defmodule Min.URLsTest do
  use Min.DataCase

  import Min.Links

  alias Min.Links.Link

  describe "create/1" do
    test "inserts a valid link" do
      {:ok, %Link{} = link} = create("http://www.abc.com")

      assert "http://www.abc.com" == link.url
      assert is_binary(link.hash)
    end

    test "does not insert a valid link" do
      {:error, changeset} = create("hi")

      assert %{url: ["is invalid"]} == errors_on(changeset)
    end

    test "returns previously inserted url" do
      {:ok, %Link{} = link_1} = create("https://www.def.com")
      {:ok, %Link{} = link_2} = create("https://www.def.com")

      assert link_1 == link_2
    end
  end
end
