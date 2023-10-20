require_relative '../classroom'
require_relative '../student'
require 'rspec'

describe Classroom do
  let(:classroom) { Classroom.new('A101') }
  let(:student) { Student.new(classroom: classroom, name: 'Alice', age: 16, parent_permission: true) }

  it 'has a label' do
    expect(classroom.label).to eq('A101')
  end

  it 'starts with no students' do
    expect(classroom.students).to be_empty
  end

  it 'can add students' do
    classroom.add_student(student)
    expect(classroom.students).to include(student)
    expect(student.classroom).to eq(classroom)
  end
end
