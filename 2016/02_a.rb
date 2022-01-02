class Code
  attr_accessor :line, :position, :lookup

  def initialize(line)
    @position = 5
    @line = line

    @lookup = {
      1 => {"U"=>1,"D"=>4,"L"=>1,"R"=>2},
      2 => {"U"=>2,"D"=>5,"L"=>1,"R"=>3},
      3 => {"U"=>3,"D"=>6,"L"=>2,"R"=>3},
      4 => {"U"=>1,"D"=>7,"L"=>4,"R"=>5},
      5 => {"U"=>2,"D"=>8,"L"=>4,"R"=>6},
      6 => {"U"=>3,"D"=>9,"L"=>5,"R"=>6},
      7 => {"U"=>4,"D"=>7,"L"=>7,"R"=>8},
      8 => {"U"=>5,"D"=>8,"L"=>7,"R"=>9},
      9 => {"U"=>6,"D"=>9,"L"=>8,"R"=>9}
    }

    walk_code
  end

  def walk_code()
    @line.split("") do |i|
      process(i)
    end
  end

  def code()
    return @position
  end

  def process(move)
    @position = @lookup[@position][move]
  end
end


File.foreach("02_input.txt").with_index do |line, line_num|
  l = line.strip!.gsub(/,/, "")
  puts l
  puts Code.new(l).code
end
