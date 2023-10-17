class UserInput
  def user_input_as_integer
    puts 'Please enter an Age:'
    input = gets.chomp
    input.to_i
  end

  def user_input_as_string
    puts 'Please enter a Name:'
    gets.chomp
  end
end
