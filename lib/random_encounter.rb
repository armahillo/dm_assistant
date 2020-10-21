require './lib/probability_table'

class RandomEncounter
  attr_reader :encounter
  attr_reader :table

  Encounter = Struct.new(:name, :description) do
    def to_s
      "#{name}\n#{description}"
    end
  end

  def initialize(table_name)
    @table = RandomEncounter.load_table(table_name)
    @encounter = eval(@table.roll.parse_dice)
  end

  def to_s
    @encounter&.to_s
  end

  def self.load_table(table_name)
    ProbabilityTable.load("./data/#{table_name}.table")
  end
end
