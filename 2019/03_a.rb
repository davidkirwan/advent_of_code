# 2019 03 a

require "set"

@directions = Array.new
@start = [0, 0]
@location = nil
@facing = :north
@wire1 = Set.new
@wire2 = Set.new
@minimum = 99999999999
@minimum_point = nil

def move_distance(d, first)
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
    if first
      @wire1.add(now)
    else
      if @wire1.include?(now)
        @wire2.add(now)
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
    move_distance(dis, (x == 0))
  end
end

puts "Nodes in wire1: #{@wire1.size}"
puts "Intersections between wire1 and wire2: #{@wire2.size}"

@wire2.each do |i|
  distance =  (@start[0] - i[0].abs + @start[1] - i[1].abs).abs
  puts "#{i.inspect} distance: #{distance}"
	if distance < @minimum
    @minimum = distance
    @minimum_point = i
  end
end

puts "Distance between [0,0] and closest intersection #{@minimum_point} is: #{@minimum}"
