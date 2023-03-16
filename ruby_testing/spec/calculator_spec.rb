# frozen_string_literal: true

require './lib/calculator'

# rubocop:disable Metrics/BlockLength

describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#substract' do
    it 'returns the substaction of two numbers' do
      calculator = Calculator.new
      expect(calculator.substract(4, 2)).to eql(2)
    end
  end

  describe '#multiply' do
    it 'returns the multiplication of two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3)).to eql(6)
    end

    it 'returns the multiplication of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5, 7)).to eql(70)
    end
  end

  describe '#divide' do
    it 'returns the division of two numbers' do
      calculator = Calculator.new
      expect(calculator.divide(4, 2)).to eql(2)
    end
  end
end

# rubocop:enable Metrics/BlockLength
