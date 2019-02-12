require './lib/probability_table'

describe "Probability Table" do
  let(:data) { { 0..5 => "first", 6..10 => "second" } }
  let(:name) { "test" }
  subject { pt = ProbabilityTable.new(name: name, data: data) }

  it "can be seeded with a hash of data" do
    expect(subject.data).to eq(data)
  end

  it "has a name attribute" do
    expect(subject.name).to eq(name)
  end

  it "can sample from the table" do
    results = RandomTrials.sample_cases(trials: 10) do
      subject.roll
    end
    expect(results).to be_a_random_sampling_of(10)
  end

  it "accepts an array of data, and will assign ranges evenly to it" do
    pt = ProbabilityTable.new(name: "Test", data: ['a','b','c'])
    expect(pt.data).to eq(Hash[1..1 => 'a', 2..2 => 'b', 3..3 => 'c'])
  end
end