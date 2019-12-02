# 2016 01 a

@directions = nil
@start = [0, 0]
@location = [0, 0]
@facing = :north

def change_left()
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

def change_right()
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

def move_distance(d)
    case @facing
    when :north
      @location[1] += d
    when :west
      @location[0] -= d
    when :south
      @location[1] -= d
    when :east
      @location[0] += d
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
