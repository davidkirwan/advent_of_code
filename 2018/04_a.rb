# Sorted the input using VIM: shift+v, G, :'<,'>sort
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
  l = line.split("]")
  l[0].gsub!("[", "")
  l[1].strip!

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


def process_events(id, event, guard_list)
  unless guard_list.has_key?(id)
    guard_list[id] = {
      :events=>[],
      :calendar=>Array.new(60,0)
    }
  end
  guard_list[id][:events] << event

  return true
end


def process_s(k, v)
  puts "Key: #{k}, #{v[:events].size}"

  v[:events].each do |i|
    puts i.inspect
  end
end


File.foreach("04_input_sorted.txt").with_index do |line, line_num|
  parsed = parse_lines(line)
  if parsed[:data][:action] == ACTION[:guard]
    id = parsed[:data][:id]
  end
  puts "At #{parsed[:time]} #{id} #{ACTION_DESCRIPTION[parsed[:data][:action]]}"

  process_events(id, parsed, guard_list)
end

guard_list.each do |k,v|
  process_s(k, v)
end


#puts "Answer is xxxxxx"
