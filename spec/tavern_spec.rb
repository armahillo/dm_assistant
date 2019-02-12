require './lib/tavern'

describe "Tavern" do
  let(:trials) { 10 }
  subject { Tavern.new }
  it "has a name" do
    expect(subject).to respond_to(:name)
  end

  it "can randomly determine the name on instantiation" do
    results = RandomTrials.sample_cases(trials: trials) do
      Tavern.new.name
    end
    expect(results).to be_a_random_sampling_of(trials)
  end

  it "can have a name provided" do
    expect(Tavern.new(name: "Test Tavern").name).to eq("Test Tavern")
  end

  it "has a size" do
    expect(subject).to respond_to(:size)
  end

  it "randomly determines the size on instantiation" do
    results = RandomTrials.sample_cases(trials: trials) do
      Tavern.new.size
    end
    expect(results).to be_a_random_sampling_of(trials)
  end

  it "can have a size provided" do
    expect(Tavern.new(size: "Giant").size).to eq("Giant")
  end
end
