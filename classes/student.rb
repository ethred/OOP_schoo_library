require_relative 'person'

class Student < Person
  attr_accessor :name, :classroom, :parent_permission

  def initialize(classroom:, name: 'Unknown', age: 0, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end
end
