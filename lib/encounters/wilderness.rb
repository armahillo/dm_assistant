require './lib/random_encounter'

class Wilderness < RandomEncounter
  def initialize(name: nil, description: nil)
    super('wilderness_forest', name: name, description: description)
  end
end
