# Foo

To reproduce the issue for yourself:

  * `docker run -d --rm -it -ePOSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=db -p 3333:5432 --name pg_foo postgres:14.6-alpine3.17`
  * Run `mix setup` to install and setup dependencies
  * Run `npm install --prefix assets`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * open `localhost:4000/bar` in a browser
  * in `FooWeb.BarLive.render/1` (file `bar_live.ex`) switch between rendering from either:
    * A) a LiveView (`BarLive` itself) using `render_from_live_view/1`, or
    * B) a LiveComponent, using `render_from_live_component/1`.
  * observe that when rendering from a LiveComponent, the results do _not_ show immediately after you type "a". The issue also occurs when you render the LiveComponent _besides_ the existing LiveView's HTML: then neither of, now 2, search inputs will show their results immediately, without any further user action (such as pressing the Enter key).
