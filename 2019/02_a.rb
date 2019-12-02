# 2019 02 a

@data = nil
OPCODES = {
    1 => "add",
    2 => "multiply",
    99 => "exit"
}

def method_with_function_as_param(callback, x) 
  callback.call(x) 
end 

def opcode_add(o)
  puts "add #{o}"
  puts "address: #{o[3]} (#{@data[o[3]]})"
  puts "address: #{o[1]} (#{@data[o[1]]})"
  puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] + @data[o[2]]
  puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[3]
end

def opcode_multiply(o)
  puts "multiply #{o}"
  puts "address: #{o[3]} (#{@data[o[3]]})"
  puts "address: #{o[1]} (#{@data[o[1]]})"
  puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] * @data[o[2]]
  puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[3]
end

def opcode_exit(opcode)
  puts "exit #{opcode}"
  return -1
end

# Instructions to change data[1] to 12
# Instructions to change data[2] to 2

File.foreach("02_input.txt").with_index do |line, line_num|
  @data = line.strip!.split(",").map(&:to_i)
  @data[1] = 12
  @data[2] = 2
  @operations = @data.clone.each_slice(4).to_a
end


0.step(@data.size, 4) do |i|
  opcode = OPCODES[@data[i]]
  puts "#{@data}"
  if opcode == "exit"
    break
  end
  method_with_function_as_param(method("opcode_#{opcode}".to_sym), [@data[i], @data[i+1], @data[i+2], @data[i+3]])
end

puts "\n\nAns: #{@data[0]}"