require './lib/probability_table'

class NameGenerator
  @@BEGINNING_TABLE = ProbabilityTable.load('./data/names/name_beginning.table')
  @@MIDDLE_TABLE = ProbabilityTable.load('./data/names/name_middle.table')
  @@END_TABLE = ProbabilityTable.load('./data/names/name_ending.table')

  attr_reader :name

  def initialize
    @name = "#{@@BEGINNING_TABLE.roll}#{@@MIDDLE_TABLE.roll}#{@@END_TABLE.roll}".capitalize
  end

  def to_s
    @name
  end
end
