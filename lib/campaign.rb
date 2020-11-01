require './lib/mixins/persistable'

class Campaign
  include Persistable

  def initialize(data = nil)
  end
end