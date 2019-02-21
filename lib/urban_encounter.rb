require './lib/random_encounter'

class UrbanEncounter < RandomEncounter
  @@ENCOUNTER_TABLE = ProbabilityTable.load('./data/encounter_urban.table')

  attr_reader :encounter

  def initialize
    @encounter = eval(@@ENCOUNTER_TABLE.roll)
  end
end