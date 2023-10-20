# rental_spec.rb

require_relative '../rental' # Adjust the path as needed
require_relative '../book' # Adjust the path as needed
require_relative '../person' # Adjust the path as needed
require 'rspec'

describe Rental do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
  let(:person) { Person.new(name: 'John', age: 25, parent_permission: true) }
  let(:date) { Time.now }
  let(:rental) { Rental.new(date, book, person) }

  it 'has a date' do
    expect(rental.date).to eq(date)
  end

  it 'is associated with a book' do
    expect(rental.book).to eq(book)
  end

  it 'is associated with a person' do
    expect(rental.person).to eq(person)
  end
end
