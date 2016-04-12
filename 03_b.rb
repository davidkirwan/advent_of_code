class House
  attr_accessor :x, :y, :presents
  @@houses = Hash.new
  @@santas_go = true

  def initialize(x, y)
    @x = x
    @y = y
    @presents = 0
  end

  def self.houses()
    return @@houses
  end

  def add_present()
    @presents += 1
  end

  def get_coordinates()
    return [@x, @y]
  end

  def self.santas_go()
    return @@santas_go
  end

  def self.next_go()
    @@santas_go = !@@santas_go
  end

  def to_s()
    return [@x, @y].to_s
  end
end


input = File.read("03_input.txt")
santa = [0,0]
robot = [0,0]
h = House.new(0, 0)
h.add_present()
h.add_present()
House.houses[[0,0].to_s] = h

input.each_char do |c|
  if House.santas_go
    case c
    when "<"
      santa[0] -= 1
    when "^"
      santa[1] += 1
    when ">"
      santa[0] += 1
    when "v"
      santa[1] -= 1
    end
    h = House.houses[santa.to_s] ||= House.new(santa[0], santa[1])
    h.add_present()
    House.houses[santa.to_s] = h
  else
    case c
    when "<"
      robot[0] -= 1
    when "^"
      robot[1] += 1
    when ">"
      robot[0] += 1
    when "v"
      robot[1] -= 1
    end
    h = House.houses[robot.to_s] ||= House.new(robot[0], robot[1])
    h.add_present()
    House.houses[robot.to_s] = h
  end
  House.next_go
end

total_houses = 0
House.houses.map {|k, v| if v.presents > 0 then total_houses += 1; end}
puts "Total houses to receive at least 1 present: " + total_houses.to_s
