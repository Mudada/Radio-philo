defmodule RadioPhilo.ChatsTest do
  use RadioPhilo.DataCase

  alias RadioPhilo.Chats

  describe "quotations" do
    alias RadioPhilo.Chats.Quotation

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def quotation_fixture(attrs \\ %{}) do
      {:ok, quotation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_quotation()

      quotation
    end

    test "list_quotations/0 returns all quotations" do
      quotation = quotation_fixture()
      assert Chats.list_quotations() == [quotation]
    end

    test "get_quotation!/1 returns the quotation with given id" do
      quotation = quotation_fixture()
      assert Chats.get_quotation!(quotation.id) == quotation
    end

    test "create_quotation/1 with valid data creates a quotation" do
      assert {:ok, %Quotation{} = quotation} = Chats.create_quotation(@valid_attrs)
      assert quotation.body == "some body"
      assert quotation.name == "some name"
    end

    test "create_quotation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_quotation(@invalid_attrs)
    end

    test "update_quotation/2 with valid data updates the quotation" do
      quotation = quotation_fixture()
      assert {:ok, %Quotation{} = quotation} = Chats.update_quotation(quotation, @update_attrs)
      assert quotation.body == "some updated body"
      assert quotation.name == "some updated name"
    end

    test "update_quotation/2 with invalid data returns error changeset" do
      quotation = quotation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_quotation(quotation, @invalid_attrs)
      assert quotation == Chats.get_quotation!(quotation.id)
    end

    test "delete_quotation/1 deletes the quotation" do
      quotation = quotation_fixture()
      assert {:ok, %Quotation{}} = Chats.delete_quotation(quotation)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_quotation!(quotation.id) end
    end

    test "change_quotation/1 returns a quotation changeset" do
      quotation = quotation_fixture()
      assert %Ecto.Changeset{} = Chats.change_quotation(quotation)
    end
  end
end
