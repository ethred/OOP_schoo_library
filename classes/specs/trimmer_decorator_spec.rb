require 'rspec'
require_relative '../trimmer_decorator'
require_relative '../person'

describe TrimmerDecorator do
  describe '#correct_name' do
    it 'trims the name to 10 characters' do
      person = Person.new
      person.instance_variable_set(:@name, 'NgalaMacFalenTawe')
      trimmer_decorator = TrimmerDecorator.new(person)
      expect(trimmer_decorator.correct_name).to eq('NgalaMacFa')
    end
  end
end
