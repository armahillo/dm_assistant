require './lib/buildings/warehouse'

describe 'Warehouse' do
  subject { Warehouse.new }

  it 'randomly determines the description on instantiation' do
    trials = 10
    results = []
    trials.times do
      results << Warehouse.new.to_s
    end
    expect(results.compact.size).to eq(10)
    expect(results.uniq.size).to be > 1
  end
end
