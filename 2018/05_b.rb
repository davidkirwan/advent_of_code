# Sorted the input using VIM: shift+v, G, :'<,'>sort
require "time"


results = {
"a" => 0,
"b" => 0,
"c" => 0,
"d" => 0,
"e" => 0,
"f" => 0,
"g" => 0,
"h" => 0,
"i" => 0,
"j" => 0,
"k" => 0,
"l" => 0,
"m" => 0,
"n" => 0,
"o" => 0,
"p" => 0,
"q" => 0,
"r" => 0,
"s" => 0,
"t" => 0,
"u" => 0,
"v" => 0,
"w" => 0,
"x" => 0,
"y" => 0,
"z" => 0
}


def process_input(input)
  input_array = input.chars
  i = 0
  loop do
    unless i == input_array.size - 1
      if input_array[i] == nil
	puts input
	puts input_array.inspect
	puts "#{i}, #{input_array.size -1}"
      else
        if input_array[i].swapcase == input_array[i + 1]
          #puts "Deleting #{input_array[i] + input_array[i+1]}"
          2.times {input_array.delete_at(i)}
        end
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

results.each do |k, v|
  output = nil
  File.foreach("05_input.txt").with_index do |line, line_num|
    complete_check = false
    input = line.strip
    #puts input.length

    input.gsub!(k, "")
    input.gsub!(k.swapcase, "")

    #puts input.length

    while not complete_check
      input, complete_check = process_input(input)
      #puts input.length
      output = input
    end
  end
  v = output.length
  puts "#{k}: #{v}"
end

puts results.min_by {|k, v| v}.inspect
