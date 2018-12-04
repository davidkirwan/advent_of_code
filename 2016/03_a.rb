class House
  attr_accessor :x, :y, :presents
  @@santa = Hash.new

  def initialize(x, y)
    @x = x
    @y = y
    @presents = 0
  end

  def self.santa()
    return @@santa
  end

  def add_present()
    @presents += 1
  end

  def get_coordinates()
    return [@x, @y]
  end

  def to_s()
    return [@x, @y].to_s
  end
end


input = File.read("03_input.txt")
santa = [0,0]
h = House.new(santa[0], santa[0])
h.add_present()
House.santa[santa.to_s] = h

input.each_char do |c|
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

  h = House.santa[santa.to_s] ||= House.new(santa[0], santa[1])
  h.add_present()
  House.santa[santa.to_s] = h
end

total_houses = 0
House.santa.map {|k, v| if v.presents > 0 then total_houses += 1; end}

puts "Total houses to receive at least 1 present: " + total_houses.to_s
