require './lib/probability_table'

class Tavern
  @@FIRST_NAME_TABLE = ProbabilityTable.new(name: "First Name", data: {
    1 => "The Silver", 
    2 => "The Golden",
    3 => "The Staggering",
    4 => "The Laughing",
    5 => "The Prancing",
    6 => "The Gilded",
    7 => "The Running",
    8 => "The Howling",
    9 => "The Slaughtered",
    10 => "The Leering",
    11 => "The Drunken",
    12 => "The Leaping",
    13 => "The Roaring",
    14 => "The Frowning",
    15 => "The Lonely",
    16 => "The Wandering",
    17 => "The Mysterious",
    18 => "The Barking",
    19 => "The Black",
    20 => "The Gleaming"
    })
  @@LAST_NAME_TABLE = ProbabilityTable.new(name: "Last Name", data: {
    1 =>  "Eel",
    2 =>  "Dolphin",
    3 =>  "Dwarf",
    4 =>  "Pegasus",
    5 =>  "Pony",
    6 =>  "Rose",
    7 =>  "Stag",
    8 =>  "Wolf",
    9 =>  "Lamb",
    10 => "Demon",
    11 => "Goat",
    12 => "Spirit",
    13 => "Horde",
    14 => "Jester",
    15 => "Mountain",
    16 => "Eagle",
    17 => "Satyr",
    18 => "Dog",
    19 => "Spider",
    20 => "Star"
    })
  attr_reader :name
  attr_reader :size

  def initialize(name: nil, size: nil)
    @name = name || "#{@@FIRST_NAME_TABLE.roll} #{@@LAST_NAME_TABLE.roll}"
    @size = size || ["Small", "Medium", "Large"].sample
  end

  def to_s
    "#{@name} (#{@size})"
  end
end
