#
state = 0

File.foreach("01_a_input.txt").with_index do |line, line_num|
  puts "#{state}, #{line}"
  state += line.to_i
end

puts "final: #{state}"
