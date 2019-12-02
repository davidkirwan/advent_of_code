# 2019 01 b

total_fuel = 0

def calculate_fuel_by_weight(w)
  f = (w / 3).floor - 2
  return (f > 0) ? f : 0  # 
end

def calculate_fuel(mod_weight)
  mod_fuel_total = 0
  f = mod_weight
  loop do
    f = calculate_fuel_by_weight(f)
    unless f == 0
      mod_fuel_total += f
    else 
      break
    end
  end
  return mod_fuel_total
end

File.foreach("01_input.txt").with_index do |line, line_num|
  mod_weight = line.to_f
  fuel = calculate_fuel(mod_weight)
  total_fuel += fuel
  puts "Total: #{total_fuel}, Module: #{mod_weight} Module fuel: #{fuel}"
end

puts "Ans: #{total_fuel}"