require 'rubygems'
require 'bundler/setup'
require 'pry'

require 'tty-prompt'

Dir['./lib/**/*.rb'].each { |f| require f }

# s = Settlement.new

# puts s.summary

quit = false

def userdata_files
  Dir['./userdata/**/*']
end

def menu
  TTY::Prompt.new.select('Choose your destiny?', ['Name', 'Urban Encounter', 'Settlement', 'Load Settlement', 'Tavern', 'Undersea Encounter', 'Forest Encounter', 'Warehouse', 'Quit'], per_page: 10)
end

def prompt_for_settlement
  settlements = userdata_files
  TTY::Prompt.new.select('Choose a settlement') do |menu|
    settlements.each do |filename|
      menu.choice File.basename(filename).split(/[-.]/)[1], filename
    end
  end
end

def do_selection(choice)
  puts "\n* * * * * * * * * * * *\n"
  case choice
  when 'Urban Encounter'
    puts RandomEncounter.new('encounter_urban')
  when 'Settlement'
    settlement = Settlement.new
    puts settlement.to_table
    settlement.save
  when 'Load Settlement'
    filename = prompt_for_settlement
    puts filename
    settlement = Settlement.load(filename)
    puts settlement.to_table
  when 'Tavern'
    puts Tavern.new
  when 'Forest Encounter'
    puts RandomEncounter.new('encounter_wilderness_forest')
  when 'Undersea Encounter'
    puts RandomEncounter.new('encounter_undersea')
  when 'Warehouse'
    puts Warehouse.new
  when 'Name'
    puts NameGenerator.new
  else
    puts 'Quitting...'
  end
  puts "\n* * * * * * * * * * * *\n"
end

until quit
  selection = menu
  do_selection(selection)
  quit = (selection == 'Quit')
end
