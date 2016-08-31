require_relative '../lib/warmup.rb'

describe Warmup do

  let(:warmup) {Warmup.new}

  describe '#gets_shout' do
    it 'receives puts' do
      allow(warmup).to receive(:gets).and_return('hello world')
      allow(warmup).to receive(:puts)
      expect(warmup.gets_shout).to eq('HELLO WORLD')
    end
  end

  describe '#triple_size' do
    it 'triples the size of array' do
      array = instance_double('Array', size: 3)
      expect(warmup.triple_size(array)).to eq(9)
    end
  end

  describe '#calls_some_methods' do
    let(:str){'hello'}
    it 'receives the #upcase method call' do
      expect(str).to receive(:upcase!).and_return('HELLO')
      warmup.calls_some_methods(str)
    end

    it 'receives the #reverse method call' do
      expect(str).to receive(:reverse!).and_return('OLLEHO')
      warmup.calls_some_methods(str)
    end

    it 'returns a different object' do
      original = str.dup
      expect(warmup.calls_some_methods(str)).not_to eq(original.upcase.reverse)
    end
  end

end