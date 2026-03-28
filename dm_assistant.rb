require 'rubygems'
require 'bundler/setup'
require 'pry'

require 'tty-prompt'

Dir['./lib/**/*.rb'].each { |f| require f }

class Runner
  ENCOUNTER_TYPES = { 'Urban' => Urban, 'Wilderness' => Wilderness, 'Undersea' => Undersea }.freeze
  BUILDING_TYPES  = { 'Tavern' => Tavern, 'Warehouse' => Warehouse }.freeze

  def initialize
    @campaign = nil
    @prompt   = TTY::Prompt.new
  end

  def run
    until (choice = main_menu) == 'Quit'
      handle(choice)
    end
  end

  private

  def divider
    puts "\n* * * * * * * * * * * *\n"
  end

  def main_menu
    header = @campaign ? "Campaign: #{@campaign.name}\n\n" : ''
    items  = ['Name', 'Encounters', 'Settlement', 'Buildings']
    items += @campaign ? ['Campaign'] : ['New Campaign', 'Load Campaign']
    items << 'Quit'
    @prompt.select("#{header}Choose your destiny?", items, per_page: 12)
  end

  def handle(choice)
    divider
    case choice
    when 'Encounters'    then handle_encounters
    when 'Settlement'    then handle_settlement_menu
    when 'Buildings'     then handle_buildings
    when 'Name'          then puts NameGenerator.new
    when 'Campaign'      then handle_campaign_menu
    when 'New Campaign'  then new_campaign
    when 'Load Campaign' then load_campaign
    end
    divider
  end

  # --- Encounters ---

  def handle_encounters
    choice = @prompt.select('Encounter type?', ENCOUNTER_TYPES.keys + ['Back'])
    return if choice == 'Back'

    encounter = ENCOUNTER_TYPES[choice].new
    puts encounter
    offer_add_to_campaign(encounter, :add_encounter)
  end

  # --- Settlements ---

  def handle_settlement_menu
    choice = @prompt.select('Settlement?', ['New Settlement', 'Load Settlement', 'Back'])
    case choice
    when 'New Settlement'  then handle_new_settlement
    when 'Load Settlement' then handle_load_settlement
    end
  end

  def handle_new_settlement
    settlement = Settlement.new
    puts settlement.to_table
    if @campaign
      offer_add_to_campaign(settlement, :add_settlement)
    else
      settlement.save
    end
  end

  def handle_load_settlement
    if @campaign
      load_settlement_from_campaign
    else
      load_settlement_from_disk
    end
  end

  def load_settlement_from_campaign
    settlements = @campaign.settlements
    if settlements.empty?
      puts 'No settlements in this campaign.'
      return
    end
    settlement = @prompt.select('Choose a settlement') do |menu|
      settlements.each { |s| menu.choice s.name.to_s, s }
    end
    puts settlement.to_table
  end

  def load_settlement_from_disk
    files = Dir['./userdata/settlement-*.yml']
    if files.empty?
      puts 'No saved settlements found.'
      return
    end
    filename = @prompt.select('Choose a settlement') do |menu|
      files.each { |f| menu.choice File.basename(f, '.yml').sub('settlement-', ''), f }
    end
    puts Settlement.load(filename).to_table
  end

  # --- Buildings ---

  def handle_buildings
    choice = @prompt.select('Building type?', BUILDING_TYPES.keys + ['Back'])
    return if choice == 'Back'

    building = BUILDING_TYPES[choice].new
    puts building
    offer_add_to_campaign(building, :add_building)
  end

  # --- Campaign ---

  def handle_campaign_menu
    choice = @prompt.select("Campaign: #{@campaign.name}", [
      'View Settlements', 'View Encounters', 'View Buildings', 'Save', 'Close', 'Back'
    ])
    case choice
    when 'View Settlements' then view_collection(@campaign.settlements, 'Settlements')
    when 'View Encounters'  then view_collection(@campaign.encounters,  'Encounters')
    when 'View Buildings'   then view_collection(@campaign.buildings,   'Buildings')
    when 'Save'             then save_campaign
    when 'Close'            then close_campaign
    end
  end

  def view_collection(items, label)
    if items.empty?
      puts "No #{label.downcase} in this campaign."
    else
      puts "#{label}:"
      items.each { |item| puts "  - #{item}" }
    end
  end

  def new_campaign
    name = @prompt.ask('Campaign name?')
    @campaign = Campaign.new(name: name)
    puts "Campaign '#{name}' created."
  end

  def load_campaign
    files = Dir['./userdata/campaign-*.yml']
    if files.empty?
      puts 'No saved campaigns found.'
      return
    end
    filename = @prompt.select('Choose a campaign') do |menu|
      files.each { |f| menu.choice File.basename(f, '.yml').sub('campaign-', ''), f }
    end
    @campaign = Campaign.load(filename)
    puts "Campaign '#{@campaign.name}' loaded."
  end

  def save_campaign
    @campaign.save
    puts "Campaign '#{@campaign.name}' saved."
  end

  def close_campaign
    save_campaign
    @campaign = nil
    puts 'Campaign closed.'
  end

  # --- Helpers ---

  def offer_add_to_campaign(item, method)
    return unless @campaign

    if @prompt.yes?("Add to campaign '#{@campaign.name}'?")
      @campaign.send(method, item)
      save_campaign
    end
  end
end

Runner.new.run
