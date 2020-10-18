require './lib/building'

class Religious < Building
  @@RELIGIOUS_BUILDING_TABLE = self.load_table('settlement_religious_building')
  
  def initialize(name: nil, size: nil)
    super(name: @@RELIGIOUS_BUILDING_TABLE.roll)
  end
end
