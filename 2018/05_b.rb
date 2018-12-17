# Sorted the input using VIM: shift+v, G, :'<,'>sort
require "time"

output = nil
counter = 0

def process_input(input)
  input_array = input.chars
  i = 0
  loop do
    unless i == input_array.size - 1
      if input_array[i].swapcase == input_array[i + 1]
        #puts "Deleting #{input_array[i] + input_array[i+1]}"
        2.times {input_array.delete_at(i)}
      end
    else
      break
    end
    i += 1
  end

  output = input_array.join
  if input == output
    complete_check = true
  else
    complete_check = false
  end
  return output, complete_check
end

File.foreach("05_input.txt").with_index do |line, line_num|
  complete_check = false
  input = line.strip
  puts input.length
  while not complete_check
    input, complete_check = process_input(input)
    puts input.length
    output = input
    counter += 1
  end
end

puts "The answer should be #{output.length}"
