description = <<-desc
A nice string is one which meets the following criteria:

- It contains at least 3 vowels (aeiou)
- It contains at least one letter that appears twice in a row (xx, abcdde)
- It does *not* contain ab, cd, pq, xy
desc

puts description


def count_vowels(str)
  str.scan(/[aeiou]/).count >= 3
end

def check_letter_occurance(str)
  index = 0
  previous_char = nil
  str.each_char do |i|
    unless previous_char.nil?
      if str[index] == previous_char then return true; end
    end
    previous_char = i
    index += 1
  end
  return false
end

def check_forbidden_strings(str)
  not ['ab', 'cd', 'pq', 'xy'].any? {|s| str.include?(s)}
end

def check_string(str)
  count_v = count_vowels(str) 
  check_f = check_forbidden_strings(str)
  check_l = check_letter_occurance(str)

  puts "-----"
  puts str
  puts "count_vowels: " + count_v.to_s
  puts "check_forbidden_strings: " + check_f.to_s
  puts "check_letter_occurance: " + check_l.to_s

  count_v && check_f && check_l
end

nice_strings = 0
input = File.read("05_input.txt")
input.each_line do |str|
  if check_string(str)
    nice_strings += 1
  end
end

puts "Nice Strings: " + nice_strings.to_s

