require './lib/probability_table'
require './lib/name_generator'
require './lib/tavern'
require './lib/warehouse'

class Settlement
  @@SIZE_TABLE = ProbabilityTable.load('./data/settlement_size.table')
  @@BUILDING_TYPE_TABLE = ProbabilityTable.load('./data/settlement_building_type.table')
  @@SHOP_TABLE = ProbabilityTable.load('./data/settlement_shops.table')
  @@RACE_RELATIONS_TABLE = ProbabilityTable.load('./data/settlement_race_relations.table')
  @@RESIDENCE_TABLE = ProbabilityTable.load('./data/settlement_residence.table')
  @@RELIGIOUS_BUILDING_TABLE = ProbabilityTable.load('./data/settlement_religious_building.table')
  @@RULER_STATUS_TABLE = ProbabilityTable.load('./data/settlement_religious_building.table')
  @@NOTABLE_TRAITS_TABLE = ProbabilityTable.load('./data/settlement_notable_traits.table')
  @@KNOWN_FOR_TABLE = ProbabilityTable.load('./data/settlement_known_for.table')
  @@CURRENT_CALAMITY_TABLE = ProbabilityTable.load('./data/settlement_current_calamity.table')

  attr_reader :name, :size, :shops, :buildings
              :race_relations

  def initialize(**presets)
    @size = presets[:size] || @@SIZE_TABLE.roll
    @name = NameGenerator.new
    @shops = []
    @buildings = []
    @race_relations = @@RACE_RELATIONS_TABLE.roll
    @known_for = @@KNOWN_FOR_TABLE.roll
    @current_calamity = @@CURRENT_CALAMITY_TABLE.roll
    @notable_trait = @@NOTABLE_TRAITS_TABLE.roll

    10.times { add_building }
  end

  def summary
    ":: #{@size} of #{@name.to_s.upcase} ::\n" +
    "Known for:".ljust(15) + "#{@known_for}\n" +
    "Notable trait:".ljust(15) + "#{@notable_trait}\n" +
    "Current calamity:".ljust(15) + "#{@current_calamity}\n" +
    "Race relations:".ljust(15) + "#{@race_relations}\n" +
    "Buildings:".ljust(15) + "\n" +
      "\t" + (@buildings - @shops).join("\n\t") + "\n" +
    "Shops:".ljust(15) + "\n" +
      "\t" + @shops.join("\n\t") + "\n"
  end

private
  # TODO: Duplicate shops shouldn't be added for smaller towns
  def add_shop
    @shops << @@SHOP_TABLE.roll
    @shops.last
  end

  def add_building
    @buildings << case @@BUILDING_TYPE_TABLE.roll.downcase
    when "residence"
      @@RESIDENCE_TABLE.roll
    when "religious"
      @@RELIGIOUS_BUILDING_TABLE.roll
    when "tavern"
      Tavern.new
    when "warehouse"
      Warehouse.new
    when "shop"
      add_shop
    end
  end
end
