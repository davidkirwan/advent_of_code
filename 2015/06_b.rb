# 2015 06 b

row, col, default_value = 1000, 1000, 0
@lights = Array.new(row){Array.new(col,default_value)}
commands = []

def light_on(x, y)
    @lights[x][y] = 1
end

def light_off(x, y)
    @lights[x][y] = 0
end

def light_toggle(x, y)
    if @lights[x][y] == 1
        light_off(x, y)
    else
        light_on(x, y)
    end
end

def on(x1, y1, x2, y2)
    x1.upto(x2) do |i|
        y1.upto(y2) do |j|
            light_on(i, j)
        end
    end
end

def off(x1, y1, x2, y2)
    x1.upto(x2) do |i|
        y1.upto(y2) do |j|
            light_off(i, j)
        end
    end
end

def toggle(x1, y1, x2, y2)
    x1.upto(x2) do |i|
        y1.upto(y2) do |j|
            light_toggle(i, j)
        end
    end
end

def count()
    x = 0

    0.upto(999) do |i|
        0.upto(999) do |j|
            if @lights[i][j] == 1
                x += 1
            end
        end
    end

    return x
end

def method_with_function_as_param(callback, x1, y1, x2, y2) 
    callback.call(x1, y1, x2, y2) 
end 

File.foreach("06_input.txt").with_index do |line, line_num|
  l = line.split(" ")
  if l.size == 4 # toggle
    c = :toggle
    t1 = l[1].split(",").map(&:to_i)
    x1 = t1[0]
    y1 = t1[1]
    t2 = l[3].split(",").map(&:to_i)
    x2 = t2[0]
    y2 = t2[1]
  else
    if l[1] == "on" #on
        c = :on
        t1 = l[2].split(",").map(&:to_i)
        x1 = t1[0]
        y1 = t1[1]
        t2 = l[4].split(",").map(&:to_i)
        x2 = t2[0]
        y2 = t2[1]
    else
        c = :off
        t1 = l[2].split(",").map(&:to_i)
        x1 = t1[0]
        y1 = t1[1]
        t2 = l[4].split(",").map(&:to_i)
        x2 = t2[0]
        y2 = t2[1]
    end
  end
  command = [c, x1, y1, x2, y2]
  commands.append(command)
end

commands.each do |i|
    #puts i.inspect
    method_with_function_as_param(method(i[0]), i[1], i[2], i[3], i[4])
end


ans = count()
puts "Total number of lights: #{ans}"