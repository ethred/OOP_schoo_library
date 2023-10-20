require 'rspec'
require_relative '../decorator'

describe Decorator do
  describe '#correct_name' do
    it 'returns the name from nameable class' do
      nameable = Nameable.new
      nameable.define_singleton_method(:correct_name) { 'Ngala mac' }
      decorator = Decorator.new(nameable)
      expect(decorator.correct_name).to eq('Ngala mac')
    end
  end
end
