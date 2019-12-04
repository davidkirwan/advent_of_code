=begin
# 2019 04 a

Rules
You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password on a sticky note, but someone threw it out.

However, they do remember a few key facts about the password:

    It is a six-digit number.
    The value is within the range given in your puzzle input.
    Two adjacent digits are the same (like 22 in 122345).
    Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).


Other than the range rule, the following are true:

    111111 meets these criteria (double 11, never decreases).
    223450 does not meet these criteria (decreasing pair of digits 50).
    123789 does not meet these criteria (no double).

How many different passwords within the range given in your puzzle input meet these criteria?

Input:
172851-675869
=end
@data = nil
@numbers = Array.new

def number_six_digits(number)
  return number.digits.size == 6
end

def number_within_range(number)
  return number >= @data[0] && number <= @data[1]
end

def number_adjacent_digits(number)
  digits = number.digits.reverse
  return digits[0] == digits[1] || digits[1] == digits[2] || digits[2] == digits[3] ||digits[3] == digits[4] || digits[4] == digits[5]
end

def number_digits_never_decrease(number)
  digits = number.digits
  return digits[0] >= digits[1] && digits[1] >= digits[2] && digits[2] >= digits[3] && digits[3] >= digits[4] && digits[4] >= digits[5]
end

def rule_check(number)
  rule1 = number_six_digits(number)
  rule2 = number_within_range(number)
  rule3 = number_adjacent_digits(number)
  rule4 = number_digits_never_decrease(number)

  if rule1 && rule2 && rule3 && rule4
    @numbers.append(number)
  end
end

File.foreach("04_input.txt").with_index do |line, line_num|
  puts line
  @data = line.strip.split("-").map(&:to_i)
  puts "Line#{line_num} Size: #{@data.size}"
end

puts @data.inspect
@data[0].upto(@data[1]) do |i|
  rule_check(i)
end

puts @numbers.inspect
puts "Number of suitable codes: #{@numbers.size}"