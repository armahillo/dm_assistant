require './lib/random_encounter'

class UrbanEncounter < RandomEncounter
  @@ENCOUNTER_TABLE = ProbabilityTable.new(name: "Urban Encounter", data: [
    Encounter.new("Animals on the loose", "The characters see one or more unexpected animals loose in the street. This challenge could be anything from a pack of baboons to an escaped circus bear, tiger, or elephant"),
    Encounter.new("Announcement", "A herald, town crier, mad person, or other individual makes an announcement on a street corner for all to hear. The announcement might foreshadow some upcoming event (such as public execution), communicate important information to the general masses (such as a new royal decree), or convey a dire omen or warning"),
    Encounter.new("Brawl", "A brawl erupts near the adventurers. It could be a tavern brawl; a battle between rival factions, families, or gangs in the city; or a struggle between city guards and criminals. The characters could be witnesses, hit by stray arrow fire, or mistaken for members of one group and attacked by the other."),
    Encounter.new("Bullies", "The characters witness 1d4+2 bullies harassing an out of towner (use the commoner statistics for all). A bully flees as soon as he or she takes any amount of damage."),
    Encounter.new("Companion", "One or more chracters are approached by a local who takes a friendly interest in the party's activities. As a twist, the would-be companion might be a spy sent to gather information on the adventurers."),
    Encounter.new("Contest", "The adventurers are drawn into an impromptu contest - anything from an intellectual test to a drinking competition - or witness a duel"),
    Encounter.new("Corpse", "The adventurers find a humanoid corpse"),
    Encounter.new("Draft", "The characters are drafted by a member of the city or town watch, who needs their help to deal with an immediate problem. As a twist, the members of the watch might be a disguised criminal trying to lure the party into an ambush (use Thug statistics) for the criminal and their cohorts"),
    Encounter.new("Drunk", "A tipsy drunk staggers toward a random party member, mistaking them for someone else."),
    Encounter.new("Fire", "A fire breaks out, and the characters have a chance to help put out the flames before it spreads."),
    Encounter.new("Found trinket", "The characters find a random trinket. (PHB Trinkets table)"),
    Encounter.new("Guard harassment", "The adventurers are cornered by 1d4+1 guards eager to throw their weight around. If threatened, the guards call out for help and might attract the attention of other guards or citizens nearby"),
    Encounter.new("Pickpocket", "A thief (use Spy statistics) tries to steal from a random character. Characters whose passive Wisdom (Perception) scores are equal to or greater than the thief's Dexterity (Sleight of Hand) check catch the theft in progress."),
    Encounter.new("Procession", "The adventurers encounter a group of citizens either parading in celebration or forming a funeral procession"),
    Encounter.new("Protest", "The adventurers see a group of citizens peacefully protesting a new law or decree. A handful of guards maintain order."),
    Encounter.new("Runaway cart", "A team of horses pulling a wagon races through the city streets. The adventurers must avoid the horses. If they stop the wagons, the owner (who is running behind the cart) is grateful"),
    Encounter.new("Shady transaction", "The characters witness a shady transaction between two cloaked figures"),
    Encounter.new("Spectacle", "The characters witness a form of public entertainment, such as a talented bard's impersonation of a royal personage, a street circus, a puppet show, a flashy magic act, a royal visit, or a public execution"),
    Encounter.new("Urchin", "A street urchin gloms onto the adventurers and follows them around until frightened off.")
    ])

  attr_reader :encounter

  def initialize
    @encounter = @@ENCOUNTER_TABLE.roll
  end
end