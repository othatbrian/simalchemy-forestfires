defmodule ForestFireSim.World do

  alias ForestFireSim.Forest

  def create(forest, fire_starter) do
    Forest.get_fires(forest)
    |> Enum.each(fire_starter)
    spawn_link(__MODULE__, :manage, [forest])
  end

  def manage(forest) do
    receive do
      {:debug_location, xy, requestor} ->
        send(requestor, {:debug_location_response,
          Forest.get_location(forest, xy)})
        manage forest
    end
  end
end
