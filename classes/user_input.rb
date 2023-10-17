class UserInput
  def user_input_as_integer
    puts 'Please enter an Age:'
    input = gets.chomp
    input.to_i
  end

  def user_input_as_string(message)
    puts message
    gets.chomp
  end

  def prompt_yes_no
    puts 'Has parent parmission? (Y/N):'
    gets.chomp
  end
end
