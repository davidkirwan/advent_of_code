input = File.read("01_input.txt")

level = 0
position = 0

input.each_char do |c|
  position += 1
  if c == "("
    level += 1
  else
    level -= 1
  end
  if level < 0 then break; end
end

puts "Position: " + position.to_s
