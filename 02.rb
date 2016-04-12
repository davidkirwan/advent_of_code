
def advent_of_code_2()
  input_array = Array.new

  f = File.open("02_input.txt", "r")

  f.each_line do |i|
    l, w, h = i.split("x")
    l = l.to_i
    w = w.to_i
    h = h.to_i

    box = box_area(l, w, h)
    slack = slack_length(l, w, h)
    wrapping_paper_total = box + slack

    ribbon = ribbon_length(l, w, h)
    bow = bow_length(l, w, h)
    ribbon_total = ribbon + bow

    data = {:l=>l, :w=>w, :h=>h,
            :wrapping_paper_total=>wrapping_paper_total,
            :box=>box, :slack=>slack,
            :ribbon=>ribbon, :bow=>bow,
            :ribbon_total=>ribbon_total}
    input_array << data
  end

  return input_array
end

def slack_length(l, w, h)
  slack = [(l*w), (w*h), (h*l)].min
  return slack
end

def box_area(l, w, h)
  box = (2 * (l*w)) + (2 * (w * h)) + (2 * (h * l))
  return box
end

def ribbon_length(l, w, h)
  dimensions = [l, w, h].sort
  dimensions.delete_at(2)
  return (2*dimensions[0]) + (2 * dimensions[1])
end

def bow_length(l, w, h)
  bow = l * w * h
  return bow
end

#####################################################
data = advent_of_code_2()

total_paper = 0
ribbon = 0
data.each do |i|
  total_paper += i[:wrapping_paper_total]
  ribbon += i[:ribbon_total]
end

puts "Total wrapping paper: " + total_paper.to_s
puts "Total ribbon lenght: " + ribbon.to_s
