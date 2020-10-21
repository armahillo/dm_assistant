module RandomTrials
  def self.sample_cases(trials: 10)
    results = []
    trials.times do
      results << yield
    end
    results
  end
end
