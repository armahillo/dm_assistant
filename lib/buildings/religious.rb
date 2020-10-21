require './lib/building'

class Religious < Building
  @@RELIGIOUS_BUILDING_TABLE = load_table('settlement_religious_building')

  def initialize(name: nil)
    super(name: name || @@RELIGIOUS_BUILDING_TABLE.roll)
  end
end
