require './lib/random_encounter'

class UnderseaEncounter < RandomEncounter
  @@ENCOUNTER_TABLE = ProbabilityTable.load('./data/encounter_undersea.table')

  attr_reader :encounter

  def initialize
    @encounter = eval(@@ENCOUNTER_TABLE.roll).parse_dice
  end
end