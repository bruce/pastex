defmodule Pastex.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Pastex.Repo

  alias Pastex.Content.Paste

  @doc """
  Returns the list of pastes.

  ## Examples

      iex> list_pastes()
      [%Paste{}, ...]

  """
  def list_pastes do
    Repo.all(Paste)
  end

  @doc """
  Gets a single paste.

  Raises `Ecto.NoResultsError` if the Paste does not exist.

  ## Examples

      iex> get_paste!(123)
      %Paste{}

      iex> get_paste!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paste!(id), do: Repo.get!(Paste, id)

  @doc """
  Creates a paste.

  ## Examples

      iex> create_paste(%{field: value})
      {:ok, %Paste{}}

      iex> create_paste(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paste(attrs \\ %{}) do
    %Paste{}
    |> Paste.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paste.

  ## Examples

      iex> update_paste(paste, %{field: new_value})
      {:ok, %Paste{}}

      iex> update_paste(paste, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paste(%Paste{} = paste, attrs) do
    paste
    |> Paste.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Paste.

  ## Examples

      iex> delete_paste(paste)
      {:ok, %Paste{}}

      iex> delete_paste(paste)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paste(%Paste{} = paste) do
    Repo.delete(paste)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paste changes.

  ## Examples

      iex> change_paste(paste)
      %Ecto.Changeset{source: %Paste{}}

  """
  def change_paste(%Paste{} = paste) do
    Paste.changeset(paste, %{})
  end

  alias Pastex.Content.File

  @doc """
  Returns the list of files.

  ## Examples

      iex> list_files()
      [%File{}, ...]

  """
  def list_files do
    Repo.all(File)
  end

  @doc """
  Gets a single file.

  Raises `Ecto.NoResultsError` if the File does not exist.

  ## Examples

      iex> get_file!(123)
      %File{}

      iex> get_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file!(id), do: Repo.get!(File, id)

  @doc """
  Creates a file.

  ## Examples

      iex> create_file(%{field: value})
      {:ok, %File{}}

      iex> create_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file(attrs \\ %{}) do
    %File{}
    |> File.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file.

  ## Examples

      iex> update_file(file, %{field: new_value})
      {:ok, %File{}}

      iex> update_file(file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file(%File{} = file, attrs) do
    file
    |> File.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a File.

  ## Examples

      iex> delete_file(file)
      {:ok, %File{}}

      iex> delete_file(file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file(%File{} = file) do
    Repo.delete(file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file changes.

  ## Examples

      iex> change_file(file)
      %Ecto.Changeset{source: %File{}}

  """
  def change_file(%File{} = file) do
    File.changeset(file, %{})
  end
end
