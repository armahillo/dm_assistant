=begin
d10   Result
1..2  Blue
3..4  Red
5     Green
6     White
7..9  Black
10    Clear
=end

class ProbabilityTable
  attr_reader :name, :top_of_range, :last_result, :last_roll, :data

  def initialize(name:, data: {})
    @name = name
    data = array_to_hash_of_ranges(data)
    @data = data.map do |range, value|
      [ normalize_to_range(range), value]
    end.to_h
    recalculate_top_of_range
    @last_result = nil
    @last_roll = 0
  end

  def <<(result:, range:)
    range = normalize_to_range(range)
    @data[range] = result
    recalculate_top_of_range
  end

  def roll
    @last_result = sample
  end

  def table(silent: false)
    output = ""
    header = "Table: #{name}"
    
    output += header + "\n" + header.size * "-" + "\n"

    @data.each do |range, value|
      output += range + "\t" + value + "\n"
    end

    puts output unless silent
    return output
  end

private
  def recalculate_top_of_range
    @top_of_range = @data.keys.map(&:max).max || 0
  end

  def sample
    return nil if @top_of_range.zero?
    @last_roll = Random.rand(@top_of_range)+1
    @data.select { |ranges| ranges.cover?(@last_roll) }.values.first
  end

  def array_to_hash_of_ranges(data_array)
    return data_array if data_array.is_a?(Hash)
    i = 0
    data_array.collect { |d| [i += 1, d] }.to_h
  end

  def normalize_to_range(value)
    return value if value.is_a?(Range)
    Range.new(value.to_i,value.to_i)
  end
end