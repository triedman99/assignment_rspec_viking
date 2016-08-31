require_relative '../lib/weapons/bow.rb'

describe Bow do

  let(:bow){Bow.new}

  describe '#initialize' do
    it 'reads the arrows' do
      expect(bow.arrows).to be_a(Fixnum)
    end

    it 'bow starts with 10 arrows' do
      expect(bow.arrows).to eq(10)
    end

    it 'starts with the arrows it was initialized with' do
      new_bow = Bow.new(20)
      expect(new_bow.arrows).to eq(20)
    end
  end

  describe '#use' do
    it 'reduces total arrows when they are used' do
      allow(bow).to receive(:use).and_return(9)
      expect(bow.use).to eq(9)
    end

    it 'throws an error when 0 arrows left' do
      no_arrows = Bow.new(0)
      allow(no_arrows).to receive(:out_of_arrows?).and_return(true)
      expect{no_arrows.use}.to raise_error("Out of arrows")
    end
  end

end