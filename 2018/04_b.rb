=begin 
2018 04 b

Sorted the input using vim commands:

shift+v, G, :'<,'>sort
%s/\[//g
%s/\]//g
%s/\(.\{-}\zs\s\)\{2}/,/g
=end

require "time"

@id = 0
@guard_list = {}
@result = {}

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

def parse_line(line)
  l = line.split(",")
  t = Time.strptime(l[0], '%Y-%m-%d %H:%M')
  
  if l[1].include?("Guard")
    action = ACTION[:guard]
    gid = (l[1].split(" ")[1].gsub!("#", "")).to_i
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

def process_line(parsed)
  if parsed[:data][:action] == ACTION[:guard]
    @id = parsed[:data][:id]
  else
    parsed[:data][:id] = @id
  end

  if @guard_list.has_key?(@id)
    @guard_list[@id][:events].append(parsed) unless parsed[:data][:action] == ACTION[:guard]
  else
    @guard_list[@id] = {
      :events => [],
      :minutes => Array.new(60,0)
    }
    @guard_list[@id][:events].append(parsed) unless parsed[:data][:action] == ACTION[:guard]
  end
  puts "At #{parsed[:time]} guard: ##{parsed[:data][:id]} #{ACTION_DESCRIPTION[parsed[:data][:action]]}"
end

File.foreach("04_input_sorted.txt").with_index do |line, line_num|
  parsed = parse_line(line)
  process_line(parsed)
end

@guard_list.each do |k,v|
  puts "guard: #{k} events: #{v[:events].size}"
  v[:events].each_with_index do |i, index|
    #puts i.inspect
    if i[:data][:action] == ACTION[:wake]
      previous = v[:events][index - 1]
      if previous[:data][:action] == ACTION[:sleep]
        e = i[:time].min
        s = previous[:time].min
        s.upto(e) do |m|
          # increment the number of minutes sleep for guard k at minute m
          v[:minutes][m] += 1
        end
      end
    end
  end
end


0.upto(59) do |i|
  most_asleep_at_minute_i = nil
  most_asleep_at_minute_count = 0

  @guard_list.each do |k,v|
    count = v[:minutes][i]
    if count > most_asleep_at_minute_count
      most_asleep_at_minute_i = k
      most_asleep_at_minute_count = count
    end
  end
  
  @result[i] = {:id => most_asleep_at_minute_i, :count=> most_asleep_at_minute_count}
end

answer = @result.max_by{|k,v| v[:count]}
puts "Result: #{answer[0] * answer[1][:id].to_i}"