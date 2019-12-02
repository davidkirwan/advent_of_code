# 2016 01 b

require "set"

@directions = nil
@start = [0, 0]
@location = [0, 0]
@facing = :north
@visited = Set.new([0,0])

def change_left()
    case @facing
    when :north
      @facing = :west
    when :west
      @facing = :south
    when :south
      @facing = :east
    when :east
      @facing = :north
    end
end

def change_right()
    case @facing
    when :north
      @facing = :east
    when :west
      @facing = :north
    when :south
      @facing = :west
    when :east
      @facing = :south
    end
end

def move_distance(d)
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

    if @visited.include?(@location)
      puts "location #{@location} visited already"
      puts "Start: #{@start.inspect} End: #{@location.inspect}"
      ans = @start[0] - @location[0] + @start[1] - @location[1]
      puts "Manhattan Distance between start and end: #{ans}"
      exit()
    else
      @visited.add(@location)
    end
  end
end

File.foreach("01_input.txt").with_index do |line, line_num|
  @directions = line.strip!.gsub(/,/, "").split(" ")
end

@directions.each do |i|
    dir = i[0]
    dis = i[1..i.size].to_i

    if dir == "L"
        change_left()
    else
        change_right()
    end

    move_distance(dis)
end

puts "Start: #{@start.inspect} End: #{@location.inspect}"
ans = @start[0] - @location[0] + @start[1] - @location[1]
puts "Manhattan Distance between start and end: #{ans}"

# 215 is not right
# 127 is not right