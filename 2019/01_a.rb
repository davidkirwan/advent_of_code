# 2019 01 a

t = 0

File.foreach("01_input.txt").with_index do |line, line_num|
  f = line.to_f
  m = (f / 3).floor - 2
  t += m
  puts "Total: #{t}, Module: #{m} Module fuel: #{f}"
end

puts "Ans: #{t}"