require './lib/probability_table'

class NameGenerator
  @@BEGINNING_TABLE = ProbabilityTable.new(name: "Beginning", data: [
    '',   '',   '',   '',   'A',  
    'Be', 'De', 'El', 'Fa', 'Jo',
    'Ki', 'La', 'Ma', 'Na', 'O', 
    'Pa', 'Re', 'Si', 'Ta', 'Va'
  ])
  @@MIDDLE_TABLE = ProbabilityTable.new(name: "Middle", data: [
    'bar',  'ched', 'dell', 'far',  'gran',
    'hal',  'jen',  'kel',  'lim',  'mor',
    'net',  'penn', 'quil', 'rond', 'sark',
    'shen', 'tur', 'vash',  'yor',  'zen'
  ])
  @@END_TABLE = ProbabilityTable.new(name: "End", data: [
    '',   'a',   'ac',  'ai', 'al',
    'am', 'an',  'ar',  'ea', 'el',
    'er', 'ess', 'ett', 'ic', 'id',
    'il', 'in',  'is',  'or', 'us'
  ])

  attr_reader :name

  def initialize
    @name = "#{@@BEGINNING_TABLE.roll}#{@@MIDDLE_TABLE.roll}#{@@END_TABLE.roll}".capitalize
  end

  def to_s
    @name
  end

end
