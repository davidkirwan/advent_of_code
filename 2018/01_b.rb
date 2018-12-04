#
state = 0
state_list = {}
answer = nil

while true
File.foreach("01_b_input.txt").with_index do |line, line_num|
  #puts "#{state}, #{line}"
  state += line.to_i
  if state_list.has_key? state then answer = state; state_list[state] += 1; break; else state_list[state] = 1; end
end

#puts "final: #{state}"

#puts state_list.inspect
if answer != nil 
  puts answer
  exit
end
end
