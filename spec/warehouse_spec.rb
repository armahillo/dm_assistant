require './lib/warehouse'

describe "Warehouse" do
  subject { Warehouse.new }
  it "has a description" do
    expect(subject).to respond_to(:description)
  end

  it "randomly determines the description on instantiation" do
    trials = 10
    results = []
    trials.times do
      results << Warehouse.new.description
    end
    expect(results.compact.size).to eq(10)
    expect(results.uniq.size).to be > 1
  end
end
