require "time"

output = 0
data = {
  :points => {},
  :xmin => 1000,
  :xmax => 0,
  :ymin => 1000,
  :ymax => 0
}

def process_input(input, i, data)
  x = input[0].to_i
  y = input[1].to_i
  data[:xmax] = x if x > data[:xmax]
  data[:ymax] = y if y > data[:ymax]
  data[:xmin] = x if x < data[:xmin]
  data[:ymin] = y if y < data[:ymin]
  data[:points][i] = {:x => x, :y => y, }
end

File.foreach("06_input.txt").with_index do |line, line_num|
  process_input(line.split(",").map(&:strip), line_num, data)
end

puts "The xmax: #{data[:xmax]} the ymax: #{data[:ymax]}"
puts "The xmin: #{data[:xmin]} the ymin: #{data[:ymin]}"
puts "Number of points: #{data[:points].size}"
puts "The answer should be #{output}"
