defmodule PastexWeb.ContentResolver do
  alias Pastex.Content

  def pastes(_, _, _) do
    {:ok, Pastex.Content.list_pastes()}
  end

  def get_files(paste, _, _) do
    files =
      paste
      |> Ecto.assoc(:files)
      |> Pastex.Repo.all()

    {:ok, files}
  end
end
