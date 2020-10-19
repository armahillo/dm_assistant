require './lib/random_encounter'

class UrbanEncounter < RandomEncounter
  ENCOUNTER_TABLE = 'encounter_urban'
  #def initialize
#@encounter = eval(self.encounter_table.roll)
#end

  protected

#  def self.encounter_table
#    self.super('encounter_urban')
#  end
end