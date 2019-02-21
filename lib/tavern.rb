require './lib/probability_table'

class Tavern
  @@FIRST_NAME_TABLE = ProbabilityTable.load('./data/tavern_first_name.table')
  @@LAST_NAME_TABLE = ProbabilityTable.load('./data/tavern_second_name.table')
  
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
