require './lib/building'

describe "Building" do
  subject { Building.new }

  describe "Class Methods" do
    describe ".building_types" do
      it "returns a string from a list of possibile buildings" do
        expect(Building.building_types.roll).to be_instance_of(String)
      end
    end

    describe ".load_buildings" do
      it "instantiates a subtype based on the :type property" do
        class ABuilding < Building; end
        building = Building.load_building({ name: "A Building", type: "ABuilding" })
        expect(building).to be_instance_of(ABuilding)
      end

      it "defaults to Building if the type doesn't exist" do
        building = Building.load_building({ name: "A Building", type: "NonBuilding" })
        expect(building).to be_instance_of(Building)
      end
    end

    describe ".random" do
      it "grabs a random building type" do
        buildings = 10.times.collect { Building.random }
        expect(buildings.uniq.size).to be > 1
      end
    end
  end

  describe "Instance Methods" do
    describe "to_s" do
      it "evaluates to the :name" do
        expect(Building.new(name: "A name").to_s).to eq("A name")
      end
    end

    describe "to_h" do
      it "provides a hash of the name and type" do
        expect(subject.to_h.keys).to match_array([:name, :type])
      end
    end

    describe "<=>" do
      it "sorts by class name" do
        class ABuilding < Building; end
        class BBuilding < Building; end
        building1 = ABuilding.new(name: "2xyz")
        building2 = BBuilding.new(name: "1abcd")
        
        expect([building2, building1].sort).to eq([building1, building2])
      end
    end

    describe "shop?" do
      it { is_expected.not_to be_shop }
    end
  end
end
