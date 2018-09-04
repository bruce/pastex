# Note: These need to be idempotent so we can run them automatically
# when running docker-compose.

alias Pastex.{Repo, Content}

pastes = [
  %Content.Paste{
    id: 1,
    name: "Hello World",
    files: [
      %Content.File{
        body: ~s[IO.puts("Hello World")]
      }
    ]
  },
  %Content.Paste{
    id: 2,
    name: "Help!",
    description: "I don't know what I'm doing!",
    files: [
      %Content.File{
        paste_id: 2,
        name: "foo.ex",
        body: """
        defmodule Foo do
          def foo, do: Bar.bar()
        end
        """
      },
      %Content.File{
        paste_id: 2,
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

for paste <- pastes do
  Repo.insert!(paste, on_conflict: :nothing)
end
