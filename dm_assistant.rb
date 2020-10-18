require 'rubygems'
require 'bundler/setup'
require 'pry'

require 'tty-prompt'

Dir["./lib/**/*.rb"].each { |f| require f }


#s = Settlement.new

#puts s.summary

u =  UrbanEncounter.new.encounter
puts u
puts u.description.parse_dice

quit = false

def menu
  prompt = TTY::Prompt.new
  prompt.select("Choose your destiny?", ["Urban Encounter", "Name", "Settlement", "Tavern", "Undersea Encounter", "Warehouse", "Quit"])
end

def do_selection(choice)
  puts "\n* * * * * * * * * * * *\n"
  case choice
  when 'Urban Encounter'
    u = UrbanEncounter.new.encounter
    puts u
    puts u.description.parse_dice    
  when 'Settlement'
    s = Settlement.new
    puts s.summary
  when 'Tavern'
    t = Tavern.new
    puts t
  when 'Undersea Encounter'
    c = UnderseaEncounter.new.encounter
    puts c
    puts c.description.parse_dice
  when 'Warehouse'
    puts Warehouse.new
  when 'Name'
    n = NameGenerator.new
    puts n
  else
    puts "Quitting..."
  end
  puts "\n* * * * * * * * * * * *\n"
end

while !quit do
  selection = menu
  p selection
  do_selection(selection)
  quit = (selection == 'Quit')
end