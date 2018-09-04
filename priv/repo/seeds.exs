# Note: These need to be idempotent so we can run them automatically
# when running docker-compose.

alias Pastex.Content

seeds = [
  %Content.Paste{
    id: 1,
    name: nil,
    description: "My first module",
    privacy: "public",
    files: [
      %Content.File{
        body: """
        defmodule Hello do
          def greet(name), do: IO.puts "Hello \#{name}"
        end
        """
      }
    ]
  },
  %Content.Paste{
    id: 2,
    name: "What does this do?",
    privacy: "private",
    files: [
      %Content.File{
        body: """
        defmodule Test do
          def loop(0), do: :done
          def loop(n), do: loop(n - 2)
        end
        """
      }
    ]
  }
]

for seed <- seeds do
  Repo.insert!(seed, on_conflict: :nothing)
end
