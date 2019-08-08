# NotABlog

*NotABlog* is a simple RESTful blog on Phoenix.

## Install

```bash
git clone https://github.com/ARtoriouSs/not-a-blog.git
cd not-a-blog
mix deps.get
mix ecto.setup
mix run priv/repo/seeds.exs
```

## Run

First you need to set secret key base:
```
export SECRET_KEY_BASE=SECRET_KEY_BASE=SAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMP
```
Or create .env file, add key to it and just `source .env`

Then run server:
```bash
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
