defmodule StarlinksWeb.StarlinkLive do
  use StarlinksWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, self(), :tick)
    end

    {:ok, assign(socket, starlink_data: %{}, starlink_id: "5eed770f096e59000698560d")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <label for="name">
    Choose starlink:
    </label>
    <div phx-hook="SelectName" phx-update="ignore">
      <select name="name">
        <option value="">None</option>
        <%= options_for_select(select_options(), @starlink_id) %>
      </select>
    </div>
    Starlink velocity: <%= @starlink_data["velocity_kms"] %> km/s <br />
    Longitude: <%= @starlink_data["longitude"] %>
    """
  end

  @impl true
  def handle_event("starlink_selected", %{"id" => id} = params, socket) do
    case id do
      "" ->
        {:noreply, assign(socket, starlink_id: "5eed770f096e59000698560d")}
      _ ->
        {:noreply, assign(socket, starlink_id: id)}
    end
  end

  @impl true
  def handle_info(:tick, %{assigns: %{starlink_id: starlink_id}} = socket) do
    body = Starlinks.Data.get_starlink(starlink_id)

    {:noreply, assign(socket, starlink_data: body)}
  end

  defp select_options do
    Starlinks.Data.get_starlinks_name_and_id
    |> Enum.reduce(%{}, fn data, acc ->
        Map.put(acc, data.name, data.id)
    end)
    |> Map.to_list()
  end
end
