defmodule RumblWeb.FileControllerTest do
  use RumblWeb.ConnCase

  alias Rumbl.Rumbl

  @create_attrs %{test: "some test"}
  @update_attrs %{test: "some updated test"}
  @invalid_attrs %{test: nil}

  def fixture(:file) do
    {:ok, file} = Rumbl.create_file(@create_attrs)
    file
  end

  describe "index" do
    test "lists all files", %{conn: conn} do
      conn = get conn, file_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Files"
    end
  end

  describe "new file" do
    test "renders form", %{conn: conn} do
      conn = get conn, file_path(conn, :new)
      assert html_response(conn, 200) =~ "New File"
    end
  end

  describe "create file" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, file_path(conn, :create), file: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == file_path(conn, :show, id)

      conn = get conn, file_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show File"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, file_path(conn, :create), file: @invalid_attrs
      assert html_response(conn, 200) =~ "New File"
    end
  end

  describe "edit file" do
    setup [:create_file]

    test "renders form for editing chosen file", %{conn: conn, file: file} do
      conn = get conn, file_path(conn, :edit, file)
      assert html_response(conn, 200) =~ "Edit File"
    end
  end

  describe "update file" do
    setup [:create_file]

    test "redirects when data is valid", %{conn: conn, file: file} do
      conn = put conn, file_path(conn, :update, file), file: @update_attrs
      assert redirected_to(conn) == file_path(conn, :show, file)

      conn = get conn, file_path(conn, :show, file)
      assert html_response(conn, 200) =~ "some updated test"
    end

    test "renders errors when data is invalid", %{conn: conn, file: file} do
      conn = put conn, file_path(conn, :update, file), file: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit File"
    end
  end

  describe "delete file" do
    setup [:create_file]

    test "deletes chosen file", %{conn: conn, file: file} do
      conn = delete conn, file_path(conn, :delete, file)
      assert redirected_to(conn) == file_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, file_path(conn, :show, file)
      end
    end
  end

  defp create_file(_) do
    file = fixture(:file)
    {:ok, file: file}
  end
end
