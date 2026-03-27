require './lib/mixins/persistable'

class Campaign
  include Persistable

  attr_reader :settlements

  def initialize(**data)
    @settlements = (data[:settlements] || []).map { |s| Settlement.new(**s) }
  end

  def add_settlement(settlement)
    @settlements << settlement
  end

  def to_yaml
    { settlements: @settlements.map(&:to_h) }.to_yaml
  end

end 