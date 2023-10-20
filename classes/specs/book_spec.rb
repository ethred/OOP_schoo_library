require_relative '../book'
require_relative '../person'
require_relative '../rental'
require 'rspec'
require 'date'

describe Book do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }
  let(:date) { Date.today }
  let(:person) { Person.new(name: 'John', age: 25, parent_permission: true) }
  before :each do
    @book = Book.new 'Something', 'Someone'
  end

  it 'has a title' do
    expect(book.title).to eq('The Great Gatsby')
  end

  it 'has an author' do
    expect(book.author).to eq('F. Scott Fitzgerald')
  end

  it 'starts with no rentals' do
    expect(book.rentals).to be_empty
  end
  it 'has a method add_rental' do
    expect(@book).to respond_to(:add_rental)
  end
end
