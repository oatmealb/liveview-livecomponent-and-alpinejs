defmodule FooWeb.BarLive do
  use FooWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, search_results: [])}
  end

  def handle_event("search", %{"search-input" => query}, socket) do
    {:noreply, assign(socket, search_results: search(query))}
  end

  def handle_event("submit", _, socket), do: {:noreply, socket}

  def search("a"), do: ["result from a LiveView"]
  def search(_), do: []

  def render(assigns) do
    # render_from_live_view(assigns)
    render_from_live_component(assigns)
  end

  def render_from_live_component(assigns) do
    ~H"""
    <.live_component module={FooWeb.BarComponent} id="t" />
    """
  end

def render_from_live_view(assigns) do
  ~H"""
  <div class="flex-col relative" x-data="{open: false}">
    <p>Using LiveView, the result will immediately show below, without needing to also press Enter key.</p>
    <form id="search-form" phx-submit="submit">
      <input
        placeholder="type 'a'"
        name="search-input"
        id="search-input"
        class="block border border-black"
        phx-change="search"
        phx-hook="FocusOnMounted"
        x-on:focus="open = true"
      />
    </form>
    <ul :if={@search_results != []} x-show="open">
      <li :for={result <- @search_results}><%= result %></li>
    </ul>
  </div>
  """
end
end
