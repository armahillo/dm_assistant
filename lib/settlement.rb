require './lib/probability_table'
require './lib/name_generator'
require './lib/tavern'
require './lib/warehouse'

class Settlement
  @@SIZE_TABLE = ProbabilityTable.new(name: "City Size", data: {
      1..5    => "Outpost",
      6..15   => "Village",
      16..70  => "Town",
      71..95  => "City",
      96..100 => "Metropolis"
  })

  @@BUILDING_TYPE_TABLE = ProbabilityTable.new(name: "Building Type", data: {
    1..10 => "Residence",
    11..12 => "Religious",
    13..15 => "Tavern",
    16..17 => "Warehouse",
    18..20 => "Shop"
    })
  
  @@SHOP_TABLE = ProbabilityTable.new(name: "Shops", data: [
    'Pawnshop', 'Herbs/incense', 'Fruits/Vegetables', 'Dried Meats',
    'Pottery', 'Undertaker', 'Books', 'Moneylender', 'Weapons/armor',
    'Chandler', 'Smithy', 'Carpenter', 'Weaver', 'Jeweler',
    'Baker', 'Mapmaker', 'Tailor', 'Ropemaker', 'Mason', 'Scribe'
  ])

  @@RACE_RELATIONS_TABLE = ProbabilityTable.new(name: "Race Relations", data: {
    1..10  => "Harmony",
    11..14 => "Tensionn or rivalry",
    15..16 => "Racial majority are conquerors",
    17     => "Racial minority are rulers",
    18     => "Racial minority are refugees",
    19     => "Racial majority oppresses minority",
    20     => "Racial minority oppresses majority"
    })

  @@RESIDENCE_TABLE = ProbabilityTable.new(name: "Residence", data: {
    1..2 => "Abandoned squat",
    3..8 => "Middle-class home",
    9..10 => "Upper-class home",
    11..15 => "Crowded tenement",
    16..17 => "Orphange",
    18 => "Hidden slaver's den",
    19 => "Front for secret cult",
    20 => "Lavish guarded mansion"
    })

  @@RELIGIOUS_BUILDING_TABLE = ProbabilityTable.new(name: "Religious Building", data: {
    1..10 => "Temple to a Good or Neutral Deity",
    11..12 => "Temple to a False deity (run by Charlatan Priests)",
    13 => "Home of Ascetics", 
    14..15 => "Abandoned Shrine",
    16..17 => "Library dedicated to religious study",
    18..20 => "Hidden shrine to a fiend or Evil deity"
    })

  @@RULER_STATUS_TABLE = ProbabilityTable.new(name: "Ruler Status", data: {
    1..5 => "Respected, fair and just",
    6..8 => "Feared Tyrant",
    9 => "Weakling, manipulated by others",
    10 => "Illegitimate ruler, simmering civil war",
    11 => "Ruled or controlled by a powerful monster",
    12 => "Mysterious, anonymous cabal",
    13 => "Contested leadership, open fighting",
    14 => "Cabal seized power openly",
    15 => "Doltish lout",
    16 => "On deathbed; claimants compete for power",
    17..18 => "Iron-willed by respected",
    19..20 => "Religious leader"
    })

    @@NOTABLE_TRAITS_TABLE = ProbabilityTable.new(name: "Notable Traits", data: [
      "canals in place of streets",
      "massive statue or monument",
      "grand temple",
      "large fortress",
      "parks and orchards",
      "river divides town",
      "major trade center",
      "headquarters of a powerful family or guild",
      "population mostly wealthy",
      "destitute, rundown",
      "awful smell (tanneries, open sewers)",
      "center for trade for one specific good",
      "site of many battles",
      "site of a mythic or magical event",
      "important library or archive",
      "worship of all gods banned",
      "sinister reputation",
      "notable library or academy",
      "site of important tomb or graveyard",
      "built atop ancient ruins"
      ])

    @@KNOWN_FOR_TABLE = ProbabilityTable.new(name: "Known for", data: [
      "delicious cuisine",
      "rude people",
      "greedy merchants",
      "artists and writers",
      "great hero / savior",
      "flowers",
      "hordes of beggars",
      "tough warriors",
      "dark magic",
      "decadence",
      "piety",
      "gambling",
      "godlessness",
      "education",
      "wines",
      "high-fashion",
      "political intrigue",
      "powerful guilds",
      "strong drink",
      "patriotism"
      ])

    @@CURRENT_CALAMITY_TABLE = ProbabilityTable.new(name: "Current Calamity", data: {
      1 => "suspected vampire infestation",
      2 => "new cult seeks converts",
      3 => "important figure died, murder suspected",
      4 => "war between rival thieves guilds",
      5..6 => "plague or famine, sparks riots",
      7 => "corrupt officials",
      8..9 => "marauding monsters",
      10 => "powerful wizard has moved into town",
      11 => "economic depression, trade disrupted",
      12 => "flooding",
      13 => "undead stirring in cemeteries",
      14 => "prophecy of doom",
      15 => "brink of war",
      16 => "internal strife leads to anarchy",
      17 => "besieged by enemies",
      18 => "scandal threatens powerful families",
      19 => "dungeon discovered, adventurers flock to town",
      20 => "religious sects struggle for power"
      })

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
