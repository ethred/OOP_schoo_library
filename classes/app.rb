require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative 'specialization'
require 'date'
require 'json'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @classrooms = []
    @specializations = []
  end

  def list_books
    puts 'List of Books:'
    @books.each { |book| puts " Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      if person.is_a?(Teacher)
        puts "[Teacher] Name:#{person.name} ID: #{person.id}  Age:#{person.age}"
      elsif person.is_a?(Student)
        puts "[Student] Name:#{person.name} ID:#{person.id} Age:#{person.age}"
      else
        puts "Unknown Type: Name: #{person.name} ID:#{person.id} Age:#{person.age}"
      end
    end
  end

  def create_person
    puts 'Do you want to create a teacher (1) or a student (2)? [Input the number]'
    type_option = gets.chomp.to_i

    case type_option
    when 1
      create_teacher
    when 2
      create_student
    else
      puts 'Invalid option'
    end
  end

  def create_teacher
    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter name for the teacher:'
    name = gets.chomp

    puts 'Specialization:'
    specialization_label = gets.chomp

    specialization = find_or_create_specialization(specialization_label)

    teacher = Teacher.new(name: name, age: age, specialization: specialization)
    @people << teacher
    puts 'Person created successfully!'
  end

  def find_or_create_specialization(label)
    specialization = @specializations.find { |s| s.label == label }
    if specialization.nil?
      specialization = Specialization.new(label)
      @specializations << specialization
    end
    specialization
  end

  def create_student
    puts 'Enter age:'
    age = gets.chomp.to_i

    puts 'Enter name for the student:'
    name = gets.chomp

    puts 'Has parent permission?(Y/N):'
    parent_permission = gets.chomp.upcase == 'Y'

    puts 'Enter classroom'
    classroom_label = gets.chomp

    classroom = find_or_create_classroom(classroom_label)

    student = Student.new(name: name, age: age, parent_permission: parent_permission, classroom: classroom)
    @people << student
    puts 'Person created succesfully!'
  end

  def find_or_create_classroom(label)
    classroom = @classrooms.find { |c| c.label == label }
    unless classroom
      classroom = Classroom.new(label)
      @classrooms << classroom
    end

    classroom
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully.'
  end

  def create_rental
    puts 'Select a person from the following list by number (not id):'
    list_people_with_numbers
    person_number = gets.chomp.to_i

    selected_person = @people[person_number - 1]

    if selected_person
      puts 'Select a book from the following list by number'
      list_books_with_numbers
      book_number = gets.chomp.to_i

      selected_book = @books[book_number - 1]

      if selected_book
        puts 'Date (YYYY-MM-DD):'
        gets.chomp

        begin
          date = Time.now
          rental = Rental.new(date, selected_book, selected_person)
          @rentals << rental
          puts 'Rental created successfully'
        rescue ArgumentError
          puts 'Invalid date format. Please use YYYY-MM-DD.'
        end
      else
        puts 'Invalid book selection'
      end
    else
      puts 'Invalid person selection'
    end
  end

  def list_books_with_numbers
    @books.each_with_index do |book, index|
      puts "#{index + 1}. #{book.title} by #{book.author}"
    end
  end

  def list_people_with_numbers
    @people.each_with_index do |person, index|
      puts "#{index + 1}. #{person.name} (ID: #{person.id})"
    end
  end

  def list_rentals_for_person
    puts 'ID of person:'
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person
      puts 'Rentals:'
      person.rentals.each do |rental|
        puts " Date: #{rental.date.strftime('%y-%m-%d')}, Book: #{rental.book.title} by #{rental.book.author} "
      end
    else
      puts 'Person not found.'
    end
  end

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
  rescue Errno::ENOENT
    # Handle the case when one or more files are missing
    puts 'One or more data files are missing. Starting with empty data.'
  end

  private

  def save_books
    books_data = @books.map { |book| { 'title' => book.title, 'author' => book.author } }
    File.write('books.json', JSON.pretty_generate(books_data))
  end

  def load_books
    if File.exist?('books.json')
      books_data = JSON.parse(File.read('books.json'))
      @books = books_data.map { |book_data| Book.new(book_data['title'], book_data['author']) }
    else
      @books = []
    end
  end

  def save_people
    people_data = @people.map do |person|
      if person.is_a?(Teacher)
        { 'name' => person.name, 'age' => person.age, 'specialization' => person.specialization.label }
      else
        { 'name' => person.name, 'age' => person.age }
      end
    end
    File.write('people.json', JSON.pretty_generate(people_data))
  end

  def load_people
    if File.exist?('people.json')
      people_data = JSON.parse(File.read('people.json'))
      @people = people_data.map do |person_data|
        if person_data['specialization']
          specialization = find_or_create_specialization(person_data['specialization'])
          Teacher.new(specialization: specialization,
                      name: person_data['name'], age: person_data['age'])
        else
          classroom_label = person_data['classroom']
          classroom = find_or_create_classroom(classroom_label)
          Student.new(name: person_data['name'], age: person_data['age'], classroom: classroom)
        end
      end
    else
      puts 'Warning: "people.json" file not found.'
      @people = []
    end
  rescue JSON::ParserError => e
    puts "Error parsing 'people.json': #{e.message}"
    @people = []
  end

  def save_rentals
    rentals_data = @rentals.map do |rental|
      {
        'date' => rental.date.strftime('%Y-%m-%d %H:%M:%S'),
        'book' => { 'title' => rental.book.title, 'author' => rental.book.author },
        'person' => { 'id' => rental.person.id, 'name' => rental.person.name, 'age' => rental.person.age }
      }
    end
    File.write('rentals.json', JSON.pretty_generate(rentals_data))
  end

  def load_rentals
    if File.exist?('rentals.json')
      rentals_data = JSON.parse(File.read('rentals.json'))
      @rentals = rentals_data.map do |rental_data|
        book = find_book_by_title(rental_data['book']['title'])
        person = find_person_by_id(rental_data['person']['id'])

        if book && person
          Rental.new(DateTime.parse(rental_data['date']), book, person)
        else
          puts "Warning: Skipping invalid rental data - #{rental_data}"
          nil
        end
      end.compact
    else
      puts 'Warning: "rentals.json" file not found.'
      @rentals = []
    end
  rescue JSON::ParserError => e
    puts "Error parsing 'rentals.json': #{e.message}"
    @rentals = []
  end

  # Add helper methods to find book and person by title or id
  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end
end
