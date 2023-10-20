require_relative '../person'
require 'rspec'

describe Person do
  let(:person) { Person.new(name: 'John', age: 25, parent_permission: true) }

  it 'adds a new rental to the rental list of a person' do
    rental = double('Rental')
    person.add_rental(rental)
    expect(person.rentals).to include(rental)
  end

  it 'returns true if the person is of age' do
    expect(person.can_use_services?).to be true
  end

  it 'returns true if the person has parent permission' do
    person = Person.new(name: 'John', age: 16, parent_permission: true)
    expect(person.can_use_services?).to be true
  end

  it 'returns false if the person is not of age and does not have parent permission' do
    person = Person.new(name: 'John', age: 14, parent_permission: false)
    expect(person.can_use_services?).to be false
  end

  it 'returns the actual name' do
    expect(person.correct_name).to eq('John')
  end

  context 'private methods' do
    it '#of_age? returns true if the person is 18 years old or older' do
      person = Person.new(name: 'John', age: 18, parent_permission: false)
      expect(person.send(:of_age?)).to be true
    end

    it '#of_age? returns false if the person is younger than 18 years old' do
      person = Person.new(name: 'John', age: 17, parent_permission: false)
      expect(person.send(:of_age?)).to be false
    end
  end
end
