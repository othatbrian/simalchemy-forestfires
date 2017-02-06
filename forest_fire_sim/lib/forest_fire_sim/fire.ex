defmodule ForestFireSim.Fire do
  def ignite(world, xy, intensity) do
    spawn_link(__MODULE__, :burn, [world, xy, intensity])
  end

  def burn(world, xy, intensity) do
    receive do
      :advance ->
        send(world, {:advance_fire, xy})
    end
  end
end
