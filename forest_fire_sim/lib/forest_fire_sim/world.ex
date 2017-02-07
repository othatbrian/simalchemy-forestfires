defmodule ForestFireSim.World do

  alias ForestFireSim.Forest

  def create(forest, fire_starter) do
    Forest.get_fires(forest)
    |> Enum.each(fire_starter)
    spawn_link(__MODULE__, :manage, [forest, fire_starter])
  end

  def manage(forest, fire_starter) do
    receive do
      {:debug_location, xy, requestor} ->
        send(requestor, {:debug_location_response,
          Forest.get_location(forest, xy)})
        manage(forest, fire_starter)
      {:advance_fire, xy} ->
        {new_forest, new_fires} = Forest.spread_fire(forest, xy)
        Enum.each(new_fires, fn {xy, intensity} ->
          fire_starter.({xy, intensity}) end)
        Forest.reduce_fire(new_forest, xy)
        |> manage(fire_starter)
      :render ->
        Forest.to_string(forest)
        |> IO.puts
        manage(forest, fire_starter)
    end
  end
end
