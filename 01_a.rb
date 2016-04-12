input = File.read("01_input.txt")

level = 0

input.each_char do |c|
  if c == "("
    level += 1
  else
    level -= 1
  end
end

puts "Level: " + level.to_s
