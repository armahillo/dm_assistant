require './lib/building'

class Warehouse < Building
  @@TABLE = self.load_table('settlement_warehouse')

  def initialize
    super(name: @@TABLE.roll)
  end
end
