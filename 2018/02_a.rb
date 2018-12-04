#
two, three =  0, 0

def split_and_count(l)
  x = {}
  l.each_char do |i|
    if x.has_key? i then x[i] += 1; else x[i] = 1; end
  end
  return x.select {|k, v| v > 1}
end

File.foreach("02_a_input.txt").with_index do |line, line_num|
  x = split_and_count(line)
  found2, found3 = false, false
  x.each do |k, v|
    if v == 2
      found2 = true
    else
      found3 = true
    end
  end
  two += 1 if found2
  three += 1 if found3
end

puts "Answer is #{two} * #{three} = #{two * three}"
