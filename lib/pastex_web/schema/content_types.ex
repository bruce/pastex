defmodule PastexWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern

  # Object Types

  object :content_queries do
    # paste(id: ID!): Paste
    field :paste, :paste do
      arg :id, non_null(:id)
    end

    field :pastes, list_of(:paste)

    connection field(:search, node_type: :search_result) do
      arg :first, non_null(:integer)
      arg :after, :string
      arg :filter, :search_filter
    end
  end

  connection(node_type: :search_result)

  object :paste do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string
    field :author, :user
    field :privacy, non_null(:privacy)
    field :files, non_null(list_of(:file))
    field :file_count, non_null(:integer)
  end

  object :file do
    field :id, non_null(:id)
    field :paste, non_null(:paste)
    field :name, non_null(:string)
    field :body, non_null(:string)
  end

  object :comment do
    field :id, non_null(:id)
    field :paste, non_null(:paste)
    field :author, :user
    field :body, non_null(:string)
  end

  # Input Types

  input_object :search_filter do
    field :matching, :string
  end

  input_object :create_paste_input do
    field :name, non_null(:string)
    field :description, :string
    field :privacy, non_null(:privacy)
    field :files, non_null(list_of(non_null(:create_file_input)))
  end

  input_object :create_file_input do
    field :name, non_null(:string)
    field :body, non_null(:string)
  end

  input_object :update_paste_input do
    field :name, :string
    field :description, :string
    field :privacy, :privacy
    field :files, list_of(non_null(:update_file_input))
  end

  input_object :update_file_input do
    field :name, :string
    field :body, :string
  end

  input_object :create_comment_input do
    field :body, :string
  end

  # Unions

  union :search_result do
    types [:paste, :user]
  end

  enum :privacy do
    value :public
    value :private
  end

  scalar :email do
    parse(fn x, _ -> {:ok, x} end)
    serialize(&to_string/1)
  end
end
