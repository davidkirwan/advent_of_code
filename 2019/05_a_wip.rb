# 2019 05 a WIP

@data = nil
OPCODES = {
    1 => "add",
    2 => "multiply",
    3 => "input",
    4 => "output",
    99 => "exit"
}

TARGET = 19690720

def method_with_function_as_param(callback, x) 
  callback.call(x) 
end 

def opcode_add(o)
  #puts "add #{o}"
  #puts "address: #{o[3]} (#{@data[o[3]]})"
  #puts "address: #{o[1]} (#{@data[o[1]]})"
  #puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] + @data[o[2]]
  #puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[1], o[2], @data[o[3]]
end

def opcode_multiply(o)
  #puts "multiply #{o}"
  #puts "address: #{o[3]} (#{@data[o[3]]})"
  #puts "address: #{o[1]} (#{@data[o[1]]})"
  #puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] * @data[o[2]]
  #puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[1], o[2], @data[o[3]]
end

def opcode_input(o)
  #puts "multiply #{o}"
  #puts "address: #{o[3]} (#{@data[o[3]]})"
  #puts "address: #{o[1]} (#{@data[o[1]]})"
  #puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] * @data[o[2]]
  #puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[1], o[2], @data[o[3]]
end

def opcode_output(o)
  #puts "multiply #{o}"
  #puts "address: #{o[3]} (#{@data[o[3]]})"
  #puts "address: #{o[1]} (#{@data[o[1]]})"
  #puts "address: #{o[2]} (#{@data[o[2]]})"
  @data[o[3]] = @data[o[1]] * @data[o[2]]
  #puts "address: #{o[3]} data: #{@data[o[3]]}\n"
  return o[1], o[2], @data[o[3]]
end

def opcode_exit(opcode)
  puts "exit #{opcode}"
  return -1
end

# Instructions to change data[1] to 12
# Instructions to change data[2] to 2

File.foreach("05_input.txt").with_index do |line, line_num|
  @original_data = line.strip!.split(",").map(&:to_i)
end

@data = @original_data.clone
0.upto(99) do |k|
  99.downto(0) do |j|
    @data[1] = k
    @data[2] = j

    0.step(@data.size, 4) do |i|
      opcode = OPCODES[@data[i]]
      if opcode == "exit" || opcode.nil?
        break
      end
      method_with_function_as_param(method("opcode_#{opcode}".to_sym), [@data[i], @data[i+1], @data[i+2], @data[i+3]])
      if @data[0] == TARGET
        puts "Found inputs which creates target: #{TARGET}"
        puts "noun: #{k}"
        puts "verb: #{j}"

        puts "100 * #{k} + #{j} = #{100 * k + j}"
        exit()
      end
    end
    @data = @original_data.clone
  end
end