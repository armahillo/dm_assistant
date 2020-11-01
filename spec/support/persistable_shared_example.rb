RSpec.shared_examples "Persistable" do
  let(:fake_file) { 'spec/data/fake_persisted.yml' }

  subject(:klass) { described_class }
  subject(:instance) { described_class.new }

  describe ".load" do
    it "raises an error if the file isn't found" do
      expect do
        klass.load('nonexistent_file.yml')
      end.to raise_error(StandardError)
    end

    it "loads the file into a new instance of the class" do
      fake = double(klass.name)
      allow(klass).to receive(:new).and_return(fake)
      expect(klass.load(fake_file)).to eq(fake)
    end
  end

  describe "#save" do
    it "uses a default_filename if none is provided" do

    end

    it "writes to a yaml file" do

    end
  end

  describe "#default_filename" do
    it { is_expected.to be_respond_to(:default_filename) }
  end
end