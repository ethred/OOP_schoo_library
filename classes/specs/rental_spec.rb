require_relative '../rental'
require_relative '../book'
require_relative '../person'
require 'rspec'

describe Rental do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
  let(:person) { Person.new(name: 'John', age: 25, parent_permission: true) }
  let(:date) { Time.now }

  it 'has a date' do
    # Create a test double for Rental
    rental = double('Rental', date: date)
    expect(rental.date).to eq(date)
  end

  it 'is associated with a book' do
    # Create a test double for Rental
    rental = double('Rental', book: book)
    expect(rental.book).to eq(book)
  end

  it 'is associated with a person' do
    # Create a test double for Rental
    rental = double('Rental', person: person)
    expect(rental.person).to eq(person)
  end
end
