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

  def create_paste(_, %{input: input}, _) do
    result = Content.create_paste(input)

    case result do
      {:ok, paste} ->
        {:ok, paste}

      {:error, changeset} ->
        {:error, transform_errors(changeset)}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, value} ->
        %{key: key, message: value}
    end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
