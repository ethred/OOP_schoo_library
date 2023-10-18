require_relative 'app'
require_relative 'save_load'

class LibraryApp
  include SaveLoad

  def initialize
    @library = App.new
    load_data
  end

  def run
    puts 'Welcome to the School Library App!'
    loop do
      show_options
      option = gets.chomp.to_i
      break if option == 7

      call_option(option)
    end
  end

  def show_options
    puts <<~OPTIONS
      Please choose an option by entering a number:
      1 - List of all books
      2 - List of all people
      3 - Create a person
      4 - Create a book
      5 - Create a rental
      6 - List all rentals for a given person id
      7 - Exit
    OPTIONS
  end

  def call_option(option)
    case option
    when 1
      @library.list_books
    when 2
      @library.list_people
    when 3
      @library.create_person
    when 4
      @library.create_book
    when 5
      @library.create_rental
    when 6
      @library.list_rentals
    end
  end
end
