require './lib/random_encounter'

class UnderseaEncounter < RandomEncounter
  @@ENCOUNTER_TABLE = ProbabilityTable.new(name: "Undersea Encounter", data: [
    Encounter.new("Sunken ship covered in barnacles", "There is a 25% chance that the ship contains treasure; roll randomly on treasure tables in chapter 7)"),
    Encounter.new("Sunken ship with Sharks", "Either Reef Sharks (shallow waters) or Hunter Sharks (deep waters) are circling around the sunken ship (50% chance that the ship contains treasure, roll randomly)"),
    Encounter.new("Bed of giant oysters", "Each oyster has a 1% chance of having a giant 5,000gp pearl inside"),
    Encounter.new("Underwater steam vent", "25% chance that the vent is a portal to the Elemental Plane of Fire"),
    Encounter.new("Sunken ruin", "Uninhabited"),
    Encounter.new("Sunken ruin", "Inhabited or Haunted"),
    Encounter.new("Sunken statue or monolith", ""),
    Encounter.new("Friendly and curious Giant Sea Horse", ""),
    Encounter.new("Friendly Patrol", "Merfolk"),
    Encounter.new("Hostile Patrol", "Merrow (shallow waters), Sahaugin (deep waters)"),
    Encounter.new("Enormous kelp bed", "Roll again on the table to determine what's hidden in the kelp bed"),
    Encounter.new("Undersea cave", "(Empty)"),
    Encounter.new("Undersea cave", "Sea Hag lair"),
    Encounter.new("Undersea cave", "Merfolk lair"),
    Encounter.new("Undersea cave", "giant octopus lair"),
    Encounter.new("Undersea cave", "dragon turtle lair"),
    Encounter.new("Bronze dragon searching for treasure", ""),
    Encounter.new("Storm giant walking on the ocean floor", ""),
    Encounter.new("Sunken treasure chest", "25% chance that it contains something of value; roll treasure randomly")
    ])

  attr_reader :encounter

  def initialize
    @encounter = @@ENCOUNTER_TABLE.roll
  end
end