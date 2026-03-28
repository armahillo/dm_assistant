require './lib/settlement'

describe Settlement do
  it_behaves_like "Persistable"

  describe "#to_h" do
    subject(:settlement) { Settlement.new(name: 'Testton', size: 'Town', race_relations: 'Harmony',
                                          known_for: 'trade', current_calamity: 'drought',
                                          notable_trait: 'tall walls', buildings: []) }

    it "includes all expected keys" do
      expect(settlement.to_h.keys).to match_array(%i[name size race_relations known_for current_calamity notable_trait buildings])
    end

    it "reflects preset values" do
      h = settlement.to_h
      expect(h[:name]).to eq('Testton')
      expect(h[:size]).to eq('Town')
    end
  end

  describe "building partitioning" do
    subject(:settlement) do
      Settlement.new(buildings: [
        { name: 'The Rusty Nail', type: 'Tavern'    },
        { name: 'Weaver',        type: 'Shop'       },
        { name: 'Old House',     type: 'Residence'  }
      ])
    end

    it "places shops in #shops" do
      expect(settlement.shops.map(&:class)).to all(eq(Shop))
    end

    it "keeps non-shops out of #shops" do
      expect(settlement.buildings.map(&:class)).not_to include(Shop)
    end
  end

  describe "preset constructor" do
    it "uses provided name" do
      expect(Settlement.new(name: 'Saltmarsh').name.to_s).to eq('Saltmarsh')
    end

    it "uses provided size" do
      expect(Settlement.new(size: 'Hamlet').size).to eq('Hamlet')
    end
  end
end
