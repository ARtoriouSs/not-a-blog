use Mix.Config

# Configure your database
config :not_a_blog, NotABlog.Repo,
  username: "not_a_blog",
  password: "not_a_blog",
  database: "not_a_blog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :not_a_blog, NotABlogWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
