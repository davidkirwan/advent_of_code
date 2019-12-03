# 2019 03 b

require "set"

@directions = Array.new
@start = [0, 0]
@location = nil
@facing = :north

@wire1 = {
  :points => Set.new,
  :step_data => {}
}
@wire2 = {
  :points => Set.new,
  :step_data => {}
}

@intersect = Set.new
@minimum = 99999999999
@minimum_point = nil
@minimum_steps = 99999999999

def move_distance(d, step_total, w1)
  1.upto(d) do |i|
    case @facing
    when :north
      @location[1] += 1
    when :west
      @location[0] -= 1
    when :south
      @location[1] -= 1
    when :east
      @location[0] += 1
    end

    now = [@location[0], @location[1]]

    if w1
      @wire1[:points].add(now)
      @wire1[:step_data][now] = step_total + i
    else
      @wire2[:points].add(now)
      @wire2[:step_data][now] = step_total + i
      if @wire1[:points].include?(now)
        @intersect.add(now)
      end
    end
  end
end

File.foreach("03_input.txt").with_index do |line, line_num|
  puts line
  x = line.strip!.split(",")
  puts "Line#{line_num} Size: #{x.size}"
  @directions.append(x)
end

@directions.each_with_index do |j, x|
  @location = @start.clone # Reset to [0,0]
  step_total = 0
  
  j.each_with_index do |i, y|
    puts "line#{x} direction #{y}" if y % 50 == 0

    dir = i[0]
    dis = i[1..i.size].to_i

    case dir
    when "L"
        @facing = :west
    when "R"
        @facing = :east
    when "U"
      @facing = :north
    when "D"
      @facing = :south
    end
    move_distance(dis, step_total, (x == 0))
    step_total += dis
  end
end

puts "#######"
puts "Nodes in wire1: #{@wire1[:points].size}"
puts "Nodes in wire2: #{@wire2[:points].size}"
puts "Intersections between wire1 and wire2: #{@intersect.size}"

@intersect.each do |i|
  distance = (@start[0] - i[0].abs + @start[1] - i[1].abs).abs
  s1 = @wire1[:step_data][i]
  s2 = @wire2[:step_data][i]
  step = s1 + s2
  puts "#{i.inspect} distance: #{distance} steps: #{step}"

  if step < @minimum_steps
    @minimum = distance
    @minimum_steps = step
    @minimum_point = i
  end
end

puts "Distance between [0,0] and closest intersection #{@minimum_point} of distance: #{@minimum} with minimum steps: #{@minimum_steps}"
