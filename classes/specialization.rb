class Specialization
  attr_accessor :label
  attr_reader :teachers

  def initialize(label)
    @label = label
    @teachers = []
  end

  def add_teacher(teacher)
    teachers << teacher
    teacher.specialization = self
  end
end
