#
require "set"

count = 0
rows, cols = 1000, 1000
grid = Array.new(rows) { Array.new(cols) }

lines = []
File.foreach("03_a_input.txt").with_index do |line, line_num|
  lines << line
end

def parse_lines(line)
  l = line.split(" ")
  l.delete_at(1)
  l[0].gsub!("#", "")
  l[1].gsub!(":", "")
  coord = l[1].split(",")
  size_coord =  l[2].split("x")

  num = l[0].to_i
  x = coord[0].to_i
  y = coord[1].to_i
  size_x = size_coord[0].to_i
  size_y = size_coord[1].to_i

  return num, x, y, size_x, size_y
end

lines.each do |l|
  puts l
  n, x, y, size_x, size_y = parse_lines(l)

  x.upto(x + size_x - 1) do |i|
    y.upto(y + size_y - 1) do |j|
      if grid[i][j] == nil
	grid[i][j] = n.to_s
      else
	grid[i][j] = "X"
      end
    end
  end

end


0.upto(999) do |i|
  0.upto(999) do |j|
    if grid[i][j] == "X"
      count += 1
    end
  end
end

puts "Answer is #{count}"
