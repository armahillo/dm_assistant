RSpec::Matchers.define :be_a_random_sampling_of do |expected|
  match do |actual|
    (actual.uniq.size > 1) && (actual.compact.size == expected)
  end
end
