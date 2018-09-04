defmodule Pastex.ContentTest do
  use Pastex.DataCase

  alias Pastex.Content

  describe "pastes" do
    alias Pastex.Content.Paste

    @valid_attrs %{description: "some description", name: "some name", privacy: "some privacy"}
    @update_attrs %{
      description: "some updated description",
      name: "some updated name",
      privacy: "some updated privacy"
    }
    @invalid_attrs %{description: nil, name: nil, privacy: nil}

    def paste_fixture(attrs \\ %{}) do
      {:ok, paste} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_paste()

      paste
    end

    test "list_pastes/0 returns all pastes" do
      paste = paste_fixture()
      assert Content.list_pastes() == [paste]
    end

    test "get_paste!/1 returns the paste with given id" do
      paste = paste_fixture()
      assert Content.get_paste!(paste.id) == paste
    end

    test "create_paste/1 with valid data creates a paste" do
      assert {:ok, %Paste{} = paste} = Content.create_paste(@valid_attrs)
      assert paste.description == "some description"
      assert paste.name == "some name"
      assert paste.privacy == "some privacy"
    end

    test "create_paste/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_paste(@invalid_attrs)
    end

    test "update_paste/2 with valid data updates the paste" do
      paste = paste_fixture()
      assert {:ok, paste} = Content.update_paste(paste, @update_attrs)
      assert %Paste{} = paste
      assert paste.description == "some updated description"
      assert paste.name == "some updated name"
      assert paste.privacy == "some updated privacy"
    end

    test "update_paste/2 with invalid data returns error changeset" do
      paste = paste_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_paste(paste, @invalid_attrs)
      assert paste == Content.get_paste!(paste.id)
    end

    test "delete_paste/1 deletes the paste" do
      paste = paste_fixture()
      assert {:ok, %Paste{}} = Content.delete_paste(paste)
      assert_raise Ecto.NoResultsError, fn -> Content.get_paste!(paste.id) end
    end

    test "change_paste/1 returns a paste changeset" do
      paste = paste_fixture()
      assert %Ecto.Changeset{} = Content.change_paste(paste)
    end
  end

  describe "files" do
    alias Pastex.Content.File

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def file_fixture(attrs \\ %{}) do
      {:ok, file} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_file()

      file
    end

    test "list_files/0 returns all files" do
      file = file_fixture()
      assert Content.list_files() == [file]
    end

    test "get_file!/1 returns the file with given id" do
      file = file_fixture()
      assert Content.get_file!(file.id) == file
    end

    test "create_file/1 with valid data creates a file" do
      assert {:ok, %File{} = file} = Content.create_file(@valid_attrs)
      assert file.body == "some body"
      assert file.name == "some name"
    end

    test "create_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_file(@invalid_attrs)
    end

    test "update_file/2 with valid data updates the file" do
      file = file_fixture()
      assert {:ok, file} = Content.update_file(file, @update_attrs)
      assert %File{} = file
      assert file.body == "some updated body"
      assert file.name == "some updated name"
    end

    test "update_file/2 with invalid data returns error changeset" do
      file = file_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_file(file, @invalid_attrs)
      assert file == Content.get_file!(file.id)
    end

    test "delete_file/1 deletes the file" do
      file = file_fixture()
      assert {:ok, %File{}} = Content.delete_file(file)
      assert_raise Ecto.NoResultsError, fn -> Content.get_file!(file.id) end
    end

    test "change_file/1 returns a file changeset" do
      file = file_fixture()
      assert %Ecto.Changeset{} = Content.change_file(file)
    end
  end
end
