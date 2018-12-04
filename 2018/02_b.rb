#
lines = []

def split_and_count_difference(i, j)
  x = 0
  d = 0
  0.upto(i.size) do |k|
    unless i[k] == j[k]
      x += 1 
      d = k
    end
  end
  return x, d
end

File.foreach("02_a_input.txt").with_index do |line, line_num|
  lines << line
end

lines.each do |i|
  lines.each do |j|
    diff, index = split_and_count_difference(i, j)
    if diff == 1
      answer = i.chars
      answer.delete_at(index)
      answer.join
      puts i, j, diff, index, "Answer is #{answer.join}"
      exit
    end
  end
end
