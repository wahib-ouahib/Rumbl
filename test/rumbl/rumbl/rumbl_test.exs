defmodule Rumbl.RumblTest do
  use Rumbl.DataCase

  alias Rumbl.Rumbl

  describe "files" do
    alias Rumbl.Rumbl.File

    @valid_attrs %{test: "some test"}
    @update_attrs %{test: "some updated test"}
    @invalid_attrs %{test: nil}

    def file_fixture(attrs \\ %{}) do
      {:ok, file} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rumbl.create_file()

      file
    end

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Rumbl.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Rumbl.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      assert {:ok, %File{} = file} = Rumbl.create_file(@valid_attrs)
      assert file.test == "some test"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rumbl.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      assert {:ok, file} = Rumbl.update_file(file, @update_attrs)
      assert %File{} = file
      assert file.test == "some updated test"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Rumbl.update_file(file, @invalid_attrs)
      assert file == Rumbl.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Rumbl.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Rumbl.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Rumbl.change_file(file)
    end
  end
end
