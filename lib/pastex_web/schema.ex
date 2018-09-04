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

    field :files, non_null(list_of(:file)) do
      resolve &get_files/3
    end
  end

  object :file do
    field :paste, non_null(:paste)

    field :name, :string do
      resolve fn file, _, _ ->
        {:ok, Map.get(file, :name) || "Untitled"}
      end
    end

    field :body, :string
  end

  @pastes [
    %{
      id: 1,
      name: "Hello World"
    },
    %{
      id: 2,
      name: "Help!",
      description: "I don't know what I'm doing!"
    }
  ]

  def list_pastes(_, _, _) do
    {:ok, @pastes}
  end

  @files [
    %{
      paste_id: 1,
      body: ~s[IO.puts("Hello World")]
    },
    %{
      paste_id: 2,
      name: "foo.ex",
      body: """
      defmodule Foo do
        def foo, do: Bar.bar()
      end
      """
    },
    %{
      paste_id: 2,
      name: "bar.ex",
      body: """
      defmodule Bar do
        def bar, do: Foo.foo()
      end
      """
    }
  ]

  def get_files(paste, _, _) do
    files =
      Enum.filter(@files, fn file ->
        file.paste_id == paste.id
      end)

    {:ok, files}
  end
end
