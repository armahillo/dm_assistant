require './lib/building'

class Residence < Building
  @@RESIDENCE_TABLE = load_table('settlement_residence')

  def initialize(name: nil)
    super(name: name || @@RESIDENCE_TABLE.roll)
  end
end
