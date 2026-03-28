require './lib/random_encounter'

class Undersea < RandomEncounter
  def initialize(name: nil, description: nil)
    super('undersea', name: name, description: description)
  end
end
