defmodule ForestFireSim.Fire do
  def ignite(world, xy, intensity) do
    spawn_link(__MODULE__, :burn, [world, xy, intensity])
  end

  def burn(world, xy, intensity) do
    receive do
      :advance ->
        send(world, {:advance_fire, xy})
        if intensity <= 1, do: exit :normal
        burn(world, xy, intensity - 1)
    end
  end
end
