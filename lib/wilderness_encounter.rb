require './lib/random_encounter'

class WildernessEncounter < RandomEncounter
  @@ENCOUNTER_TABLE = ProbabilityTable.load('./data/encounter_wilderness_forest.table')

  attr_reader :encounter

  def initialize
    @encounter = eval(@@ENCOUNTER_TABLE.roll)
  end
end
