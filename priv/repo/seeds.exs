alias Pastex.{Repo, Content, Identity}

users = [
  %{
    name: "Ben Wilson",
    email: "ben@localhost.com",
    password: "abc123"
  },
  %{
    name: "Rich Kilmer",
    email: "rich@localhost.com",
    password: "abc123"
  }
]

[user1, user2] =
  Enum.map(users, fn params ->
    {:ok, user} = params |> Identity.create_user()
    user
  end)

pastes = [
  %Content.Paste{
    name: "Hello World"
  },
  %Content.Paste{
    author_id: user1.id,
    name: "Help!",
    description: "I don't know what I'm doing!"
  },
  %Content.Paste{
    author_id: user1.id,
    name: "Just for me",
    visibility: "private"
  }
]

[past1, past2, past3 | _] =
  for paste <- pastes |> Stream.cycle() |> Enum.take(100) do
    Repo.insert!(paste)
  end

files = [
  %Content.File{
    paste_id: past1.id,
    body: ~s[IO.puts("Hello World")]
  },
  %Content.File{
    paste_id: past2.id,
    name: "foo.ex",
    body: """
    defmodule Foo do
      def foo, do: Bar.bar
    end
    """
  },
  %Content.File{
    paste_id: past2.id,
    name: "bar.ex",
    body: """
    defmodule Bar do
      def bar, do: Foo.foo
    end
    """
  },
  %Content.File{
    paste_id: past3.id,
    name: "foo.ex",
    body: """
    IO.puts("this is secret")
    """
  }
]

for file <- files do
  Repo.insert!(file)
end
