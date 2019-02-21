class Dice
  attr_reader :result
  def initialize(rolls: 1, faces: 6)
    @result = 0
    rolls.to_i.times { @result += Random.rand(faces.to_i) + 1 }
  end

  def self.parse(dice_string)
    rolls, faces = dice_string.split("d")
    Dice.new(rolls: rolls, faces: faces)
  end
end

class String
  def parse_dice
    dice_string_regex = %r{\b\d+d\d+\b}
    self.gsub(dice_string_regex) do |dice_string|
      Dice.parse(dice_string).result
    end
  end
end