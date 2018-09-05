defmodule PastexWeb.ContentResolver do
  alias Pastex.Content

  ## Queries

  def list_pastes(_, _, %{context: context}) do
    {:ok, Content.list_pastes(context[:current_user])}
  end

  def get_files(paste, _, _) do
    files =
      paste
      |> Ecto.assoc(:files)
      |> Pastex.Repo.all()

    {:ok, files}
  end

  ## Mutations

  def create_paste(_, %{input: input}, %{context: context}) do
    input =
      case context do
        %{current_user: %{id: user_id}} ->
          Map.put(input, :author_id, user_id)

        _ ->
          input
      end

    case Content.create_paste(input) do
      {:ok, paste} ->
        {:ok, paste}

      {:error, _} ->
        {:error, "didn't work"}
    end
  end

  def format_body(file, arguments, _) do
    case arguments |> IO.inspect() do
      %{style: :formatted} ->
        {:ok, Code.format_string!(file.body)}

      _ ->
        {:ok, file.body}
    end
  end
end
