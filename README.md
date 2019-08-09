# NotABlog

**NotABlog** is a simple RESTful blog on Phoenix. I don't like word "blog", so it's not a blog. It's just sample application to learn Elixir, but you can check it out [here](https://not-a-blog.herokuapp.com/ "NotABlog on Heroku") (Heroku puts to sleep free dynos if they are inactive for some time, so it will take some time to start up, and can throw 500. Just reload the page and it should be OK).

## Install

Clone this repo:
```bash
git clone https://github.com/ARtoriouSs/not-a-blog.git
cd not-a-blog
```
Install dependencies:
```bash
mix deps.get
```
Setup database:
```bash
mix ecto.setup
mix run priv/repo/seeds.exs
```

## Run

First of all you need to set up SECRET_KEY_BASE environment variable:
```
export SECRET_KEY_BASE=SECRET_KEY_BASE=$(mix phx.gen.secret)
```
Or create .env file, add key to it and just `source .env`

Then run server:
```bash
mix phx.server
```
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deploy

Unfortunately this app isn't use any cool Elixir features :( But this makes it possible to deploy it to Heroku witout any limitations. To do it just follow [Phoenix deployment guides](https://hexdocs.pm/phoenix/heroku.html "Heroku deployment").
