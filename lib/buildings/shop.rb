require './lib/building'

class Shop < Building
  @@SHOP_TABLE = load_table('shops')

  def initialize(name: nil)
    super(name: name || @@SHOP_TABLE.roll)
  end

  def shop?
    true
  end
end
