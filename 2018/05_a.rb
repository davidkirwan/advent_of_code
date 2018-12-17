# Sorted the input using VIM: shift+v, G, :'<,'>sort
require "time"

output = nil
counter = 0

def process_input(input)
  input_array = input.chars.each_slice(2).map(&:join)
  output = input_array.reject do |i|
    i[0] != i[1] && i[0].upcase == i[1] || i[0].downcase == i[1]
  end
  output = output.join
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

puts counter

