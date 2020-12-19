require './lib/campaign'

describe Campaign do
  subject(:campaign) { Campaign.new }

  it_behaves_like "Persistable"

  describe "settlements" do
    it { is_expected.to be_respond_to(:settlements) }
  end

  describe "add_settlement" do
    it "adds a settlement to the internal collection" do
      settlement = instance_double(Settlement)

      expect do
        campaign.add_settlement(settlement)
      end.to change{campaign.settlements.size}.by(1)
    end
  end
end