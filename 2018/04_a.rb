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
  
  calendar = v[:calendar]
  last_event = nil
  total_minutes = 0

  v[:events].each do |i|
    #puts i.inspect
    if i[:data][:action] == 1
      if last_event[:data][:action] == 0
	puts i[:time]
	puts last_event[:time]
	puts i[:time].min - last_event[:time].min
	puts
	start = last_event[:time].min
	finish = i[:time].min

	total_minutes += (finish-start)
        start.upto(finish) do |x|
	  calendar[x] += 1
	end
      end
    end
    v[:total_minutes] = total_minutes
    puts calendar.inspect
    last_event = i
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

guard_with_most_sleep_id = 0
guard_with_most_sleep = 0


guard_list.each do |k,v|
  if guard_with_most_sleep < v[:total_minutes]
    guard_with_most_sleep_id = k
    guard_with_most_sleep = v[:total_minutes]
  end
  puts "Guard #{k}, slept for: #{v[:total_minutes]}"
end


puts "Guard with most sleep is #{guard_with_most_sleep_id} with total of: #{guard_with_most_sleep}"
puts guard_list[guard_with_most_sleep_id][:calendar].inspect



