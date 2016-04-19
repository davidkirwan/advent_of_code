description = <<-desc
--- Part Two ---

Realizing the error of his ways, Santa has switched to a better model of determining whether a string
is naughty or nice. None of the old rules apply, as they are all clearly ridiculous.

Now, a nice string is one with all of the following properties:

- It contains a pair of any two letters that appears at least twice in the string without
  overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).

- It contains at least one letter which repeats with exactly one letter between them, like xyx,
  abcdefeghi (efe), or even aaa.


For example:

- qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that
  repeats with exactly one letter between them (zxz).
- xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between,
  even though the letters used by each rule overlap.
- uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.
- ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair
  that appears twice.

How many strings are nice under these new rules?
desc

puts description


def check_pairs(str)
  targets = Array.new
  (0 .. (str.size - 2)).step(1) do |i|
    targets << str[i .. i + 1]
  end

  targets.each do |i|
    r = Regexp.new(Regexp.escape(i))
    if str.scan(r).length > 1 then return true; end
  end

  false
end

def check_repeating_letter(str)
  targets = Array.new
  (0 .. (str.size - 3)).step(1) do |i|
    targets << str[i .. i + 2]
  end

  targets.each do |i|
    if i[0] == i[2] then return true; end
  end

  false
end


def check_string(str)
  check_one = check_pairs(str)
  check_two = check_repeating_letter(str)
  check_one && check_two
end


nice_strings = 0
input = File.read("05_input.txt")
input.each_line do |str|
  if check_string(str)
    nice_strings += 1
  end
end

puts "Nice Strings: " + nice_strings.to_s
