require './lib/campaign'

describe Campaign do
  subject(:campaign) { Campaign.new(name: 'Test') }

  it_behaves_like "Persistable"

  describe "#name" do
    it { is_expected.to be_respond_to(:name) }
  end

  describe "#settlements" do
    it { is_expected.to be_respond_to(:settlements) }
  end

  describe "#encounters" do
    it { is_expected.to be_respond_to(:encounters) }
  end

  describe "#buildings" do
    it { is_expected.to be_respond_to(:buildings) }
  end

  describe "#add_settlement" do
    it "adds a settlement to the collection" do
      settlement = instance_double(Settlement)
      expect { campaign.add_settlement(settlement) }.to change { campaign.settlements.size }.by(1)
    end
  end

  describe "#add_encounter" do
    it "adds an encounter to the collection" do
      encounter = instance_double(Urban)
      expect { campaign.add_encounter(encounter) }.to change { campaign.encounters.size }.by(1)
    end
  end

  describe "#add_building" do
    it "adds a building to the collection" do
      building = instance_double(Tavern)
      expect { campaign.add_building(building) }.to change { campaign.buildings.size }.by(1)
    end
  end

  describe "#to_yaml / round-trip" do
    it "serializes and reconstructs name" do
      data = YAML.safe_load(campaign.to_yaml, permitted_classes: [Symbol])
      expect(data[:name]).to eq('Test')
    end
  end
end
