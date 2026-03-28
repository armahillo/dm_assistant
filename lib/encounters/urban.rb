require './lib/random_encounter'

class Urban < RandomEncounter
  def initialize(name: nil, description: nil)
    super('urban', name: name, description: description)
  end
end
