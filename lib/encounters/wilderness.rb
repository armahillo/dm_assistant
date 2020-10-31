require './lib/random_encounter'

class Wilderness < RandomEncounter
  def initialize
    super('wilderness_forest')
  end
end
