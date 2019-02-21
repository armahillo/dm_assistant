require './lib/name_generator'

describe "Name Generator" do
  let(:trials) { 10 }
  subject { NameGenerator.new }

  it "produces random names" do
    results = RandomTrials.sample_cases(trials: trials) do
      NameGenerator.new.to_s
    end
    expect(results).to be_a_random_sampling_of(trials)
  end
end
