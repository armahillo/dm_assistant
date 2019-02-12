require './lib/probability_table'

class RandomEncounter
  Encounter = Struct.new(:name, :description) do
    def to_s
      name
    end
  end
end