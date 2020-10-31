require './lib/building'

class Residence < Building
  @@RESIDENCE_TABLE = load_table('residence')

  def initialize(name: nil)
    super(name: name || @@RESIDENCE_TABLE.roll)
  end
end
