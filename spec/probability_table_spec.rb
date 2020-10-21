require './lib/probability_table'

describe 'Probability Table' do
  let(:data) { { 0..5 => 'first', 6..10 => 'second' } }
  let(:name) { 'test' }
  subject { pt = ProbabilityTable.new(name: name, data: data) }

  it 'can be seeded with a hash of data' do
    expect(subject.data).to eq(data)
  end

  it 'has a name attribute' do
    expect(subject.name).to eq(name)
  end

  it 'can sample from the table' do
    results = RandomTrials.sample_cases(trials: 10) do
      subject.roll
    end
    expect(results).to be_a_random_sampling_of(10)
  end

  it 'accepts an array of data, and will assign ranges evenly to it' do
    pt = ProbabilityTable.new(name: 'Test', data: %w[a b c])
    expect(pt.data).to eq(Hash[1..1 => 'a', 2..2 => 'b', 3..3 => 'c'])
  end

  describe 'Loading from a file' do
    let(:normal_table) { './spec/support/standard_table_sample.txt' }
    let(:no_range_table) { './spec/support/no_ranges_table_sample.txt' }
    let(:table_with_code) { './spec/support/table_with_code.txt' }
    let(:table_with_objects) { './spec/support/table_with_code_objects.txt' }

    it 'generates a new ProbabilityTable from a file' do
      expect(ProbabilityTable.load(normal_table)).to be_is_a(ProbabilityTable)
    end

    it 'accepts a table that only has results' do
      expect(ProbabilityTable.load(no_range_table)).to be_is_a(ProbabilityTable)
    end

    it 'can parse code within table results' do
      table = ProbabilityTable.load(table_with_code, true)
      expect(table).to be_is_a(ProbabilityTable)
      expect(table.roll[0]).not_to eq('"') # Shouldn't be a double-quote
    end

    it 'when parsing code within tables, it can persist objects' do
      table = ProbabilityTable.load(table_with_objects, true)
      expect(table).to be_is_a(ProbabilityTable)
      obj = table.roll.new
      expect(obj).to be_respond_to(:foo)
    end
  end
end
