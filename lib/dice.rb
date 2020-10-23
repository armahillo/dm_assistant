class Dice
  attr_reader :result
  def initialize(rolls: 1, faces: 6, operation: '+', modifier: '0')
    @result = 0
    operation ||= '+'
    modifier ||= '0'
    rolls.to_i.times { @result += Random.rand(faces.to_i) + 1 }
    @result = @result.send(operation.to_sym, modifier.to_i)
  end

  def self.parse(dice_string)
    rolls, faces, operation, modifier = dice_string.scan(/(\d+)d(\d+)(\+|\-)?(\d+)?/).flatten
    Dice.new(rolls: rolls, faces: faces, operation: operation, modifier: modifier)
  end
end

class String
  def parse_dice
    dice_string_regex = /\b\d+d\d+[\+\-]?\d?\b/
    gsub(dice_string_regex) do |dice_string|
      Dice.parse(dice_string).result
    end
  end
end
