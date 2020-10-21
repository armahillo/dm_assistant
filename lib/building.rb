require './lib/probability_table'

class Building
  attr_reader :name

  def initialize(name: nil)
    @name = name
  end

  def to_s
    name
  end

  def to_h
    {
      name: @name,
      type: self.class.to_s
    }
  end

  def <=>(other)
    self.class.to_s <=> other.class.to_s
  end

  def shop?
    false
  end

  def self.load_building(preset)
    building_type = Object.const_get(preset.delete(:type)) rescue self
    building_type.new(preset)
  end

  def self.random
    type = building_types.roll
    Object.const_get(type).new
  rescue
    self.new(name: "A Building")
  end

  def self.building_types
    @building_types ||= self.load_table('settlement_building_type')
  end

  protected

  def self.load_table(table_name)
    ProbabilityTable.load("./data/#{table_name}.table")
  end
end
