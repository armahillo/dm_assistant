require './lib/probability_table'

class Warehouse
  @@TABLE = ProbabilityTable.load('./data/settlement_warehouse.table')

  attr_reader :description

  def initialize
    @description = @@TABLE.roll
  end

  def to_s
    @description
  end

end
