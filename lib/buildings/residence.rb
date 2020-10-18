require './lib/building'

class Residence < Building
  @@RESIDENCE_TABLE = self.load_table('settlement_residence')
  
  def initialize
    super(name: @@RESIDENCE_TABLE.roll)
  end
end
