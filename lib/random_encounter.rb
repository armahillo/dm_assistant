require './lib/probability_table'

class RandomEncounter
  attr_reader :encounter
  attr_reader :table

  Encounter = Struct.new(:name, :description) do
    def to_s
      "#{name}\n#{description}"
    end
  end

  def initialize(table_name = nil, name: nil, description: nil)
    if name
      @encounter = Encounter.new(name, description)
    else
      @table = RandomEncounter.load_table(table_name)
      @encounter = Encounter.new(*@table.roll.parse_dice.split('|'))
    end
  end

  def to_s
    @encounter&.to_s
  end

  def to_h
    { type: self.class.to_s, name: @encounter.name, description: @encounter.description }
  end

  def self.load(data)
    Object.const_get(data[:type]).new(name: data[:name], description: data[:description])
  end

  def self.load_table(table_name)
    ProbabilityTable.load("./data/encounters/#{table_name}.table")
  end
end
