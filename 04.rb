require "digest"

my_input = "yzbqklnj"

counter = 1
loop do
  data = my_input + counter.to_s
  hash = Digest::MD5.hexdigest(data)
  if hash[0..4] == "00000" then break; end
  counter += 1
end
puts "The answer to part a: " + counter.to_s

counter = 1
loop do
  data = my_input + counter.to_s
  hash = Digest::MD5.hexdigest(data)
  if hash[0..5] == "000000" then break; end
  counter += 1
end
puts "The answer to part b: " + counter.to_s
