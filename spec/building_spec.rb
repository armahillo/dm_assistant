require './lib/building'

describe "Building" do
  subject { Building.new }

  describe "Class Methods" do
    describe ".building_types" do
      it "returns a string from a list of possibile buildings" do
        expect(Building.building_types.roll).to be_instance_of(String)
      end
    end
  end

  describe "to_s" do
    it "evaluates to the :name" do
      expect(Building.new(name: "A name").to_s).to eq("A name")
    end
  end

  describe "shop?" do
    it { is_expected.not_to be_shop }
  end
end
