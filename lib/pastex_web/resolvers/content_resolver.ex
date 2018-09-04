defmodule PastexWeb.ContentResolver do
  alias Pastex.Content

  def pastes(_, _, _) do
    {:ok, Content.list_pastes()}
  end

  def get_files(paste, _, _) do
    files =
      paste
      |> Ecto.assoc(:files)
      |> Pastex.Repo.all()

    {:ok, files}
  end

  def format_body(file, args, _) do
    case Map.get(args, :style) || :original do
      :original ->
        {:ok, file.body}

      :formatted ->
        {:ok, Code.format_string!(file.body)}
    end
  end
end
