require 'rubygems'
require 'bundler/setup'
require 'pry'

require 'tty-prompt'

Dir["./lib/**/*.rb"].each { |f| require f }


#s = Settlement.new

#puts s.summary

quit = false

def menu
  prompt = TTY::Prompt.new
  prompt.select("Choose your destiny?", ["Name", "Urban Encounter", "Settlement", "Tavern", "Undersea Encounter", "Forest Encounter", "Warehouse", "Quit"])
end

def do_selection(choice)
  puts "\n* * * * * * * * * * * *\n"
  case choice
  when 'Urban Encounter'
    u = UrbanEncounter.new.encounter
    puts u
    puts u.description.parse_dice    
  when 'Settlement'
    puts Settlement.new.to_table
  when 'Tavern'
    puts Tavern.new
  when 'Forest Encounter'
    c = WildernessEncounter.new.encounter
    puts c
    puts c.description.parse_dice
  when 'Undersea Encounter'
    c = UnderseaEncounter.new.encounter
    puts c
    puts c.description.parse_dice
  when 'Warehouse'
    puts Warehouse.new
  when 'Name'
    puts NameGenerator.new
  else
    puts "Quitting..."
  end
  puts "\n* * * * * * * * * * * *\n"
end

while !quit do
  selection = menu
  do_selection(selection)
  quit = (selection == 'Quit')
end