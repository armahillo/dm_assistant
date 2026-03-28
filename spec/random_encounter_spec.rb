require './lib/encounters/urban'
require './lib/encounters/wilderness'
require './lib/encounters/undersea'

describe RandomEncounter do
  describe "#to_s" do
    it "formats as name then description on a new line" do
      encounter = RandomEncounter.load(type: 'Urban', name: 'Pickpocket', description: 'A thief eyes your coin purse')
      expect(encounter.to_s).to eq("Pickpocket\nA thief eyes your coin purse")
    end
  end

  describe "#to_h" do
    it "includes type, name, and description" do
      encounter = Urban.new
      h = encounter.to_h
      expect(h.keys).to match_array(%i[type name description])
      expect(h[:type]).to eq('Urban')
    end
  end

  describe ".load" do
    it "reconstructs an encounter from a hash without re-rolling" do
      original = Urban.new
      restored = RandomEncounter.load(original.to_h)
      expect(restored.to_s).to eq(original.to_s)
    end

    it "restores the correct subclass" do
      expect(RandomEncounter.load({ type: 'Wilderness', name: 'Wolves', description: '3 wolves' })).to be_a(Wilderness)
      expect(RandomEncounter.load({ type: 'Undersea',   name: 'Shark',  description: 'A shark'   })).to be_a(Undersea)
    end
  end

  describe "subclasses" do
    it "Urban generates without error" do
      expect { Urban.new }.not_to raise_error
    end

    it "Wilderness generates without error" do
      expect { Wilderness.new }.not_to raise_error
    end

    it "Undersea generates without error" do
      expect { Undersea.new }.not_to raise_error
    end

    it "Urban accepts a preset name and description" do
      encounter = Urban.new(name: 'Fixed', description: 'Fixed desc')
      expect(encounter.to_s).to eq("Fixed\nFixed desc")
    end
  end
end
