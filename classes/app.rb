require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'user_input'
require_relative 'save_load'

class App
  include SaveLoad
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @rentals = []
    @people = []
    save_data
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_books_with_index
    @books.each_with_index { |book, i| puts "#{i}) Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_people_with_index
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class.name}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    student_or_teacher = gets.chomp.to_i
    age = UserInput.new.user_input_as_integer
    name = UserInput.new.user_input_as_string('Please enter a Name:')
    case student_or_teacher
    when 1
      create_person_instance(1, age, name)
    when 2
      create_person_instance(2, age, name)
    else
      puts "Invalid choice. Please enter a valid option. (#{student_or_teacher})"
    end
  end

  def create_person_instance(person_class, age, name)
    if person_class == 1
      parent_permission = UserInput.new.prompt_yes_no
      if parent_permission =~ /^[Yy]/
        @newstudentpermision = true
      elsif parent_permission =~ /^[Nn]/
        @newstudentpermision = false
      else
        puts "Invalid choice. Please enter a valid option. (#{parent_permission})"
        return
      end
      @newpersion = Student.new('Unknown', age, name, parent_permission: true)
    else
      specialization = UserInput.new.user_input_as_string('Please enter a Specialization:')
      @newpersion = Teacher.new(specialization, age, name)

    end
    @people.push(@newpersion)
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp.to_s

    print 'Author: '
    author = gets.chomp.to_s

    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    list_books_with_index
    book_index = gets.chomp.to_i
    unless (0...@books.length).include?(book_index)
      puts "Error adding a record. Book #{book_index} doesn't exist"
      return
    end
    book = @books[book_index]
    puts "\nSelect a person from the following list by number (not id)"
    list_people_with_index
    person_index = gets.chomp.to_i
    unless (0...@people.length).include?(person_index)
      puts "Error adding a record. Person #{person_index} doesn't exist"
      return
    end
    person = @people[person_index]
    print 'Date: '
    date = gets.chomp.to_s
    @rentals.push(Rental.new(date, book, person))
    puts 'Rental created successfully'
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    selected = @rentals.find_all { |rental| rental.person.id == id }
    if selected.empty?
      puts "Person with the given ID #{id} does not exist"
      return
    end
    puts 'Rentals:'
    selected.map { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" }
  end

  def run
    prompt
    save_data
  end
end
