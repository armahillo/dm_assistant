class Settlement
  @@SIZE_TABLE = ProbabilityTable.load('./data/settlement_size.table')
  @@RACE_RELATIONS_TABLE = ProbabilityTable.load('./data/settlement_race_relations.table')
  @@RULER_STATUS_TABLE = ProbabilityTable.load('./data/settlement_religious_building.table')
  @@NOTABLE_TRAITS_TABLE = ProbabilityTable.load('./data/settlement_notable_traits.table')
  @@KNOWN_FOR_TABLE = ProbabilityTable.load('./data/settlement_known_for.table')
  @@CURRENT_CALAMITY_TABLE = ProbabilityTable.load('./data/settlement_current_calamity.table')

  attr_reader :name, :size, :shops, :buildings
              :race_relations

  def initialize(**presets)
    @size = presets[:size] || @@SIZE_TABLE.roll
    @name = NameGenerator.new
    @race_relations = @@RACE_RELATIONS_TABLE.roll
    @known_for = @@KNOWN_FOR_TABLE.roll
    @current_calamity = @@CURRENT_CALAMITY_TABLE.roll
    @notable_trait = @@NOTABLE_TRAITS_TABLE.roll

    buildings = []
    10.times { buildings << Building.random }
    @shops, @buildings = buildings.partition(&:shop?)
  end

  def to_table
    table = TTY::Table.new(data)
    renderer = TTY::Table::Renderer::Unicode.new(table, multiline: true, padding: [1,1,0,1])
    renderer.render
  end

  private

  def data
    [[ 'Name', "#{@size} of #{@name.to_s.upcase}" ],
     [ 'Known for', @known_for ],
     [ 'Notable trait', @notable_trait ],
     [ 'Current calamity', @current_calamity ],
     [ 'Race relations', @race_relations ],
     [ 'Buildings', (@buildings - @shops).sort.join("\n") ],
     [ 'Shops', @shops.sort.join("\n") ]]
  end
end
