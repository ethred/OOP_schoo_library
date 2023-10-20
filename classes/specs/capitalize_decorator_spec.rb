require 'rspec'
require_relative '../capitalize_decorator'
require_relative '../person'

describe CapitalizeDecorator do
  describe '#correct_name' do
    it 'capitalizes the name' do
      person = Person.new
      person.name = 'ngala mac'
      decorated_person = CapitalizeDecorator.new(person)
      expect(decorated_person.correct_name).to eq('Ngala mac')
    end
  end
end
