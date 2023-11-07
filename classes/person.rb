require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(name: 'Unknown', age: 0, parent_permission: true)
    super()
    @id = generate_id
    @name = name
    @rentals = []
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    rand(1..1000)
  end
end
