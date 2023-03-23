defmodule FooWeb.BarComponent do
  alias String.Chars.Phoenix.LiveComponent
  use FooWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, search_results: [])}
  end

  def handle_event("search", %{"search-input" => query}, socket) do
    {:noreply, assign(socket, search_results: search(query))}
  end

  def handle_event("submit", _, socket), do: {:noreply, socket}

  def search("a"), do: ["result from a LiveComponent"]
  def search(_), do: []

  def render(assigns) do
    ~H"""
    <div class="flex-col relative" x-data="{open: false}">
      <p>Using LiveComponent, the result will NOT immediately show below. Unless you also press Enter key. Subsequent results though do show immediately, as expected.</p>
      <form id="search-form-livecomponent" phx-submit="submit">
        <input
          placeholder="type 'a'"
          name="search-input"
          id="search-input-livecomponent"
          class="block border border-black"
          phx-change="search"
          phx-target={@myself}
          phx-hook="FocusOnMounted"
          x-on:focus="open = true"
        />
      </form>
      <ul :if={@search_results != []} class="absolute left-0 right-0" x-show="open">
        <li :for={result <- @search_results}><%= result %></li>
      </ul>
    </div>
    """
  end
end
