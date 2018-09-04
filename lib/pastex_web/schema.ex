defmodule PastexWeb.Schema do
  use Absinthe.Schema

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    field :pastes, list_of(:paste) do
      resolve &list_pastes/3
    end
  end

  object :paste do
    field :name, non_null(:string)
    field :description, :string
    field :files, non_null(list_of(:file))
  end

  object :file do
    field :paste, non_null(:paste)
    field :name, :string
    field :body, :string
  end

  @pastes [
    %{
      name: "Hello World",
      files: [%{body: ~s[IO.puts("Hello World")]}]
    },
    %{
      name: "Help!",
      description: "I don't know what I'm doing!",
      files: [
        %{
          name: "foo.ex",
          body: """
          defmodule Foo do
            def foo, do: Bar.bar()
          end
          """
        },
        %{
          name: "bar.ex",
          body: """
          defmodule Bar do
            def bar, do: Foo.foo()
          end
          """
        }
      ]
    }
  ]

  @spec list_pastes(any(), any(), any()) :: {:ok, [%{files: [...], name: <<_::88>>}, ...]}
  def list_pastes(_, _, _) do
    {:ok, @pastes}
  end
end
