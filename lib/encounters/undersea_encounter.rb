require './lib/random_encounter'

class UnderseaEncounter < RandomEncounter
  #attr_reader :encounter

  def initialize
    super('encounter_undersea')
  end

  protected

  #def self.encounter_table
  #  super
    #self.super('encounter_undersea')
  #end
end