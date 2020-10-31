require './lib/building'

class Warehouse < Building
  @@TABLE = load_table('warehouse')

  def initialize(name: nil)
    super(name: name || @@TABLE.roll)
  end
end
