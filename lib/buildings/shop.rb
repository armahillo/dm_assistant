require './lib/building'

class Shop < Building
  @@SHOP_TABLE = self.load_table('settlement_shops')
  
  def initialize
    super(name: @@SHOP_TABLE.roll)
  end

  def shop?
    true
  end
end
