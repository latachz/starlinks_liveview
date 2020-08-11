defmodule Starlinks.Data do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.spacexdata.com/v4"
  plug Tesla.Middleware.JSON

  def get_starlinks_name_and_id() do
    {:ok, response} = get("/starlink")

    response.body
    |> Enum.map(fn %{"spaceTrack" => %{"OBJECT_NAME" => name}, "id" => id} -> %{name: name, id: id} end)
  end

  def get_starlink(id) do
    {:ok, response} = get("/starlink/#{id}")

    response.body
  end

  # def get_starlinks do
  #   for id <- 44235..45787 do
  #     {:ok, response} = get("/satellite/tle/#{id}", query: [apiKey: @api_key])
  #     response.body
  #   end
  # end

end
