require './lib/dice.rb'

def stub_die_roll(faces)
  allow(Random).to receive(:rand).with(faces).and_return(faces - 1)
end

describe 'Dice' do
  context 'given no parameters' do
    subject { Dice.new }
    it 'rolls 1d6' do
      stub_die_roll(6)
      expect(subject.result).to eq(6)
    end
  end

  context 'when provided with a number of faces' do
    subject { Dice.new(faces: 20) }
    it 'rolls that number of faces' do
      stub_die_roll(20)
      expect(subject.result).to eq(20)
    end
  end

  context 'when provided a number of trials' do
    subject { Dice.new(rolls: 3) }
    it 'rolls that many times and sums the result' do
      stub_die_roll(6)
      expect(subject.result).to eq(6 * 3)
    end
  end

  context 'when the arguments are strings instead of fixnums' do
    subject { Dice.new(rolls: '2', faces: '4') }
    it 'implicitly casts them to fixnum first' do
      stub_die_roll(4)
      expect(subject.result).to eq(2 * 4)
    end
  end

  describe 'Monkey-patching String' do
    before do
      stub_die_roll(6)
    end

    context "with a single instance" do
      subject { 'Summon 2d6 jellyfish'.parse_dice }

      it 'replaces xdy language with the result' do
        expect(subject).to eq('Summon 12 jellyfish')
      end
    end

    context "with multiple instances" do
      subject { 'Summon 1d6 jellyfish and 2d6 seahorses'.parse_dice }

      it 'is able to replace multiple dice occurences' do
        expect(subject).to eq('Summon 6 jellyfish and 12 seahorses')
      end
    end
    
    context 'when it includes a positive modifier' do
      subject { 'Summon 1d6+1 jellyfish'.parse_dice }

      it "adds the modifier" do
        expect(subject).to eq('Summon 7 jellyfish')
      end
    end

    context 'when it includes a negative modifier' do
      subject { 'Summon 1d6-1 jellyfish'.parse_dice }

      it "subtracts the modifier" do
        expect(subject).to eq('Summon 5 jellyfish')
      end
    end
  end
end
