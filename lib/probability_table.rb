=begin
d10   Result
1..2  Blue
3..4  Red
5     Green
6     White
7..9  Black
10    Clear
=end

require 'tty-table'

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

    body = []
    @data.each do |range, value|
      body << [range, value]
      output += range + "\t" + value + "\n"
    end

    puts TTY::Table.new(["Range","Results"], body) unless silent  

    return output
  end

=begin
# Expects a file like:
Name of Table
1-5    First result
6-15   Second result
16     Single number result
17-70  Third result
# comments are ignored
71-95  Fourth result
96-100 Fifth result
=end
  def self.load(filename, evaluate = false)
    file = File.read(filename)
    lines = file.split("\n")
    table_name = lines.shift
    lines.reject! { |l| l.match(/^[\-=#]+/) } # Omit all commented lines

    table_data = if file_uses_ranges?(lines)
      parse_lines_with_ranges(lines, evaluate).to_h
    else
      lines.map! { |l| eval(l) } if evaluate
      lines
    end

    self.new(name: table_name, data: table_data)
  end

private
  def self.file_uses_ranges?(lines)
    lines.reject { |l| l.match(/^[\d\-]+[\s\t]+/).nil? }.size == lines.size
  end

  def self.parse_lines_with_ranges(lines, evaluate = false)
    lines.collect do |l|
      # This regex allows for the columns to be split by any kind of whitespace
      range, result = l.chomp.split(/[\s\t]+/,2)
      result = eval(result) if evaluate
      # s,e sets the start and end of the range
      s,e = range.match(/(\d+)?[-]?(\d+)?/)[1..2]
      e ||= s # If `e` is nil, then set it to s

      [s.to_i..e.to_i, result]  
    end
  end

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