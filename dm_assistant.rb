Dir["./lib/**/*.rb"].each { |f| require f }


s = Settlement.new

puts s.summary

u =  UrbanEncounter.new.encounter
puts u
puts u.description