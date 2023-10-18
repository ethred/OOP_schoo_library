require_relative 'app'

def welcome_message
  puts 'Welcome to School Library App!'
  puts
end

def display_menu
  puts 'Please choose an option by entering a number:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person (teacher or student)'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Quit'
end

def process_choice(choice, app)
  case choice
  when 1
    app.list_books
  when 2
    app.list_people
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals_for_person
  when 7
    puts 'Thank you for using School Library App. Goodbye!'
  else
    puts 'Invalid choice. Please choose a valid option.'
  end
end

def main
  app = App.new
  app.load_data

  welcome_shown = false

  loop do
    unless welcome_shown
      welcome_message
      welcome_shown = true
    end

    display_menu
    choice = gets.chomp.to_i

    process_choice(choice, app)

    break if choice == 7
  end
  app.save_data
end

main
