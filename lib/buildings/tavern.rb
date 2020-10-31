require './lib/building'

class Tavern < Building
  @@FIRST_NAME_TABLE = ProbabilityTable.load('./data/names/tavern_first_name.table')
  @@LAST_NAME_TABLE = ProbabilityTable.load('./data/names/tavern_second_name.table')

  attr_reader :name
  attr_reader :size

  def initialize(name: nil, size: nil)
    @size = size || %w[Small Medium Large].sample
    super(name: name || "#{@@FIRST_NAME_TABLE.roll} #{@@LAST_NAME_TABLE.roll}")
  end

  def to_s
    "#{@name} (#{@size})"
  end

  def to_h
    super.merge Hash.new(size: size)
  end
end
