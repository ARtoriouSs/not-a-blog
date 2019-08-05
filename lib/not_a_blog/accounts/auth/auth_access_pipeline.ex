defmodule NotABlog.Auth.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :not_a_blog

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
