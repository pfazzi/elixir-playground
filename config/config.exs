import Config

config :playground, Playground.Infrastructure.Database.Repo,
  database: "playground",
  username: "user",
  password: "pass",
  hostname: "localhost",
  migration_primary_key: [type: :uuid]

config :playground, ecto_repos: [Playground.Infrastructure.Database.Repo]
