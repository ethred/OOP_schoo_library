require_relative '../student'
require_relative '../classroom'
require 'rspec'

describe Student do
  let(:classroom) { Classroom.new('A101') }
  let(:student) { Student.new(classroom: classroom, name: 'Alice', age: 16, parent_permission: true) }

  it 'has a name' do
    expect(student.name).to eq('Alice')
  end

  it 'has an age' do
    expect(student.age).to eq(16)
  end

  it 'has parent permission' do
    expect(student.parent_permission).to be true
  end

  it 'belongs to a classroom' do
    expect(student.classroom).to eq(classroom)
  end

  it 'is in the classroom' do
    expect(classroom.students).to include(student)
  end
end
