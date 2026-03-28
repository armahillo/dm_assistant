require './lib/mixins/persistable'

class Campaign
  include Persistable

  attr_reader :name, :settlements, :encounters, :buildings

  def initialize(**data)
    @name        = data[:name]
    @settlements = (data[:settlements] || []).map { |s| Settlement.new(**s) }
    @encounters  = (data[:encounters]  || []).map { |e| RandomEncounter.load(e) }
    @buildings   = (data[:buildings]   || []).map { |b| Building.load_building(b) }
  end

  def add_settlement(settlement)
    @settlements << settlement
  end

  def add_encounter(encounter)
    @encounters << encounter
  end

  def add_building(building)
    @buildings << building
  end

  def default_filename
    "./userdata/campaign-#{@name}.yml"
  end

  def to_yaml
    {
      name: @name,
      settlements: @settlements.map(&:to_h),
      encounters:  @encounters.map(&:to_h),
      buildings:   @buildings.map(&:to_h)
    }.to_yaml
  end
end
