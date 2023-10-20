# teacher_spec.rb

require_relative '../teacher' # Adjust the path as needed
require_relative '../specialization' # Import the Specialization class
require 'rspec'

describe Teacher do
  let(:specialization) { Specialization.new('Mathematics') }
  let(:teacher) { Teacher.new(name: 'Mr. Smith', age: 35, specialization: specialization) }

  it 'has a name' do
    expect(teacher.name).to eq('Mr. Smith')
  end

  it 'has an age' do
    expect(teacher.age).to eq(35)
  end

  it 'has an ID' do
    expect(teacher.id).to be_a(Integer)
  end
end
