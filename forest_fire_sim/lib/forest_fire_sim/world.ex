defmodule ForestFireSim.World do

  alias ForestFireSim.Forest

  def create(forest, fire_starter) do
    #spawn_link(__MODULE__, :manage, [])
    Forest.get_fires(forest)
    |> Enum.each(fire_starter)
  end

  #def manage do
  #end
end
