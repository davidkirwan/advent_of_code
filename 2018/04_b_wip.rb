=begin 
2018 04 b

Sorted the input using vim commands:

shift+v, G, :'<,'>sort
%s/\[//g
%s/\]//g
%s/\(.\{-}\zs\s\)\{2}/,/g
=end

require "time"

id = 0
guard_list = {}

ACTION = {
  :guard => 2,
  :wake => 1,
  :sleep => 0,
  :unknown => -1
}

ACTION_DESCRIPTION = {
  2 => "starts their shift",
  1 => "wakes up",
  0 => "falls asleep",
  -1 => "Unknown"
}

def parse_lines(line)
  l = line.split(",")
  t = Time.strptime(l[0], '%Y-%m-%d %H:%M')
  
  if l[1].include?("Guard")
    action = ACTION[:guard]
    guard = l[1].split(" ")
    guard_id = guard[1].gsub!("#", "")
    gid = guard_id.to_i
  elsif l[1].include?("wakes")
    action = ACTION[:wake]
  elsif l[1].include?("falls")
    action = ACTION[:sleep]
  else
    action = ACTION[:unknown]
  end

  d = {
    :id=>gid,
    :action=>action
  }

  return {:time=>t, :data=>d}
end





File.foreach("04_input_sorted.txt").with_index do |line, line_num|
  parsed = parse_lines(line)
  if parsed[:data][:action] == ACTION[:guard]
    id = parsed[:data][:id]
  end
  puts "At #{parsed[:time]} guard: ##{id} #{ACTION_DESCRIPTION[parsed[:data][:action]]}"
end

