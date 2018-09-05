defmodule PastexWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  alias PastexWeb.ContentResolver

  object :paste do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string

    field :author, :user do
      complexity 100

      resolve fn
        %{author_id: nil}, _, _ ->
          {:ok, nil}

        %{author_id: id}, _, _ ->
          {:ok, Pastex.Identity.get_user(id)}
      end
    end

    field :files, non_null(list_of(:file)) do
      resolve &ContentResolver.get_files/3
    end
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

  connection(node_type: :paste)

  object :content_queries do
    connection field :pastes, node_type: :paste do
      complexity fn args, child_complexity ->
        trunc((1 + args[:first] * 0.1) * child_complexity)
      end

      resolve &ContentResolver.list_pastes/3
    end
  end

  object :content_mutations do
    field :create_paste, :paste do
      arg :input, non_null(:create_paste_input)
      resolve &ContentResolver.create_paste/3
    end
  end

  input_object :create_paste_input do
    field :name, non_null(:string)
    field :description, :string
    field :visibility, :string
    field :files, non_null(list_of(non_null(:file_input)))
  end

  input_object :file_input do
    field :name, :string
    field :body, :string
  end

  enum :body_style do
    value :formatted
    value :original
  end
end
