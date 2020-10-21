require 'yaml'

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
    @name = presets[:name] || NameGenerator.new
    @race_relations = presets[:race_relations] || @@RACE_RELATIONS_TABLE.roll
    @known_for = presets[:known_for] || @@KNOWN_FOR_TABLE.roll
    @current_calamity = presets[:current_calamity] || @@CURRENT_CALAMITY_TABLE.roll
    @notable_trait = presets[:notable_trait] || @@NOTABLE_TRAITS_TABLE.roll
    
    @shops, @buildings = load_buildings(presets[:buildings]).partition(&:shop?)
  end

  def to_table
    table = TTY::Table.new(data)
    renderer = TTY::Table::Renderer::Unicode.new(table, multiline: true, padding: [1,1,0,1])
    renderer.render
  end

  def save(filename = nil)
    filename ||= "./userdata/settlement-#{@name}.yml"
    File.open(filename, 'w') do |f|
      f.write(to_yaml)
    end
  end

  def self.load(filename)
    raise StandardError "#{filename} not found" unless File.exists?(filename)
    data = YAML.load(File.read(filename))
    settlement = Settlement.new(data)
  end

  private

  def load_buildings(presets)
    if presets.nil?
      10.times.collect { Building.random }
    else
      presets.collect { |b| Building.load_building(b) }
    end
  end

  def data
    [[ 'Name', "#{@size} of #{@name.to_s.upcase}" ],
     [ 'Known for', @known_for ],
     [ 'Notable trait', @notable_trait ],
     [ 'Current calamity', @current_calamity ],
     [ 'Race relations', @race_relations ],
     [ 'Buildings', (@buildings - @shops).sort.join("\n") ],
     [ 'Shops', @shops.sort.join("\n") ]]
  end

  def to_yaml
    {
      name: @name.to_s,
      size: @size,
      race_relations: @race_relations,
      known_for: @known_for,
      current_calamity: @current_calamity,
      notable_trait: @notable_trait,
      buildings: (@buildings + @shops).collect(&:to_h)
    }.to_yaml
  end
end