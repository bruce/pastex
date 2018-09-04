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
    field :name, :string do
      resolve fn file, _, _ ->
        {:ok, file[:name] || "Untitled"}
      end
    end

    field :body, :string
  end

  @pastes [
    %{
      id: 1,
      name: "Hello World",
      files: [1]
    },
    %{
      id: 2,
      name: "Help!",
      description: "I don't know what I'm doing!",
      files: [2, 3]
    }
  ]

  def list_pastes(_, _, _) do
    {:ok, @pastes}
  end

  @files [
    %{
      id: 1,
      body: ~s[IO.puts("Hello World")]
    },
    %{
      id: 2,
      name: "foo.ex",
      body: """
      defmodule Foo do
        def foo, do: Bar.bar()
      end
      """
    },
    %{
      id: 3,
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
      for id <- paste.files do
        Enum.find(@files, fn file -> file.id == id end)
      end

    {:ok, files}
  end
end
