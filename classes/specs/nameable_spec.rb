require 'rspec'
require_relative '../nameable'

describe Nameable do
  describe '#correct_name' do
    it 'raises a NotImplementedError' do
      expect { subject.correct_name }.to raise_error(NotImplementedError)
    end
  end
end
