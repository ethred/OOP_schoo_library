require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'person'
require 'json'

module SaveLoad
  def save_books
    File.open('classes/books.json', 'w') do |file|
      @books.each do |book|
        json = JSON.generate({ title: book.title, author: book.author })
        file.puts(json)
      end
    end
  end

  def save_people
    File.open('classes/people.json', 'w') do |file|
      @people.each do |person|
        json = if person.is_a?(Student)
                 JSON.generate({ type: 'Student', id: person.id, name: person.name, age: person.age,
                                 parent_permission: person.parent_permission })
               else
                 JSON.generate({ type: 'Teacher', id: person.id, name: person.name, age: person.age,
                                 specialization: person.specialization })
               end
        file.puts(json)
      end
    end
  end

  def save_rentals
    File.open('classes/rentals.json', 'w') do |file|
      @rentals.each do |rental|
        json = JSON.generate({ date: rental.date, person: @people.index(rental.person),
                               book: @books.index(rental.book) })
        file.puts(json)
      end
    end
  end

  def save_data
    save_books unless File.exists?('classes/books.json')
    save_people unless File.exists?('classes/people.json')
    save_rentals unless File.exists?('classes/rentals.json')
  end  

  def load_books
    return unless File.exist?('classes/books.json')

    @books = []
    File.foreach('classes/books.json').with_index do |line, line_num|
      begin
        element = JSON.parse(line)
        new_book = Book.new(element['title'], element['author'])
        @books.push(new_book)
      rescue JSON::ParserError => e
        puts "Error parsing line #{line_num + 1}: #{line}"
        puts e
      end
    end
  end

  def load_people
    return unless File.exist?('classes/people.json')

    @people = []
    File.foreach('classes/people.json').with_index do |line, line_num|
      begin
        element = JSON.parse(line)
        new_person = if element['type'] == 'Student'
                       Student.new(element['id'], element['name'], element['age'], element['parent_permission'])
                     else
                       Teacher.new(element['id'], element['name'], element['age'], element['specialization'])
                     end
        @people.push(new_person)
      rescue JSON::ParserError => e
        puts "Error parsing line #{line_num + 1}: #{line}"
        puts e
      end
    end
  end

  def load_rentals
    return unless File.exist?('classes/rentals.json')

    @rentals = []
    File.foreach('classes/rentals.json').with_index do |line, line_num|
      begin
        element = JSON.parse(line)
        rental_person = @people[element['person']]
        rental_book = @books[element['book']]
        new_rental = Rental.new(rental_person, rental_book, element['date'])
        @rentals.push(new_rental)
      rescue JSON::ParserError => e
        puts "Error parsing line #{line_num + 1}: #{line}"
        puts e
      end
    end
  end

  def load_data
    load_books
    load_people
    load_rentals
  end
end
