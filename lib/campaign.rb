require './lib/mixins/persistable'

class Campaign
  include Persistable

  attr_reader :settlements

  def initialize(data = nil)
    @settlements = []
  end

  def add_settlement(settlement)
    @settlements << settlement
  end

end 