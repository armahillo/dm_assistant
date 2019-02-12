require './lib/probability_table'

class Warehouse
  @@TABLE = ProbabilityTable.new(name: "Warehouse", data: {
    1..4   => "Empty or Abandoned",
    5..6   => "Heavily Guarded, Expensive Goods",
    7..10  => "Cheap Goods",
    11..14 => "Bulk Goods",
    15     => "Live Animals",
    16..17 => "Weapons / Armor",
    18..19 => "Goods from a Distant Land",
    20     => "Secret Smuggler's Den"
  })

  attr_reader :description

  def initialize
    @description = @@TABLE.roll
  end

  def to_s
    @description
  end

end
