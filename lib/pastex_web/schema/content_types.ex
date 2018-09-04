defmodule PastexWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  alias PastexWeb.ContentResolver

  object :content_queries do
    field :pastes, list_of(:paste) do
      resolve &ContentResolver.pastes/3
    end
  end

  object :content_mutations do
    field :create_paste, :paste do
      arg :input, non_null(:create_paste_input)
      resolve &ContentResolver.create_paste/3
    end
  end

  ## Objects

  object :paste do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string

    field :files, non_null(list_of(:file)) do
      resolve &ContentResolver.get_files/3
    end

    field :file_count, non_null(:integer)
  end

  object :file do
    field :id, non_null(:id)
    field :paste, non_null(:paste)

    field :name, :string do
      resolve fn file, _, _ ->
        {:ok, Map.get(file, :name) || "Untitled"}
      end
    end

    field :body, :string do
      arg :style, :body_style, default_value: :original

      resolve &ContentResolver.format_body/3
    end
  end

  enum :body_style do
    value :original
    value :formatted
  end

  ## Inputs

  input_object :create_paste_input do
    field :name, non_null(:string)
    field :description, :string
    field :files, non_null(list_of(non_null(:file_input)))
  end

  input_object :file_input do
    field :name, :string
    field :body, :string
  end
end
