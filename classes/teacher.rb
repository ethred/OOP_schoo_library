require_relative 'person'

class Teacher < Person
  attr_accessor :name, :specialization

  def initialize(specialization:, name: 'Unknown', age: 0, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @specialization = specialization
    specialization.add_teacher(self) unless specialization.teachers.include?(self)
  end
end
