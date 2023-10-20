require_relative '../book' # Adjust the path as needed
require 'rspec'

describe Book do
  let(:book) { Book.new('The Great Gatsby', 'F. Scott Fitzgerald') }

  it 'has a title' do
    expect(book.title).to eq('The Great Gatsby')
  end

  it 'has an author' do
    expect(book.author).to eq('F. Scott Fitzgerald')
  end

  it 'starts with no rentals' do
    expect(book.rentals).to be_empty
  end
end
