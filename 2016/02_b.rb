class Code
  attr_accessor :line, :position, :lookup

  def initialize(line)
    @position = 5
    @line = line

    @lookup = {
      1 => {"U"=>1,"D"=>3,"L"=>1,"R"=>1},
      2 => {"U"=>2,"D"=>6,"L"=>2,"R"=>3},
      3 => {"U"=>1,"D"=>7,"L"=>2,"R"=>4},
      4 => {"U"=>4,"D"=>8,"L"=>3,"R"=>4},
      5 => {"U"=>5,"D"=>5,"L"=>5,"R"=>6},
      6 => {"U"=>2,"D"=>"A","L"=>5,"R"=>7},
      7 => {"U"=>3,"D"=>"B","L"=>6,"R"=>8},
      8 => {"U"=>4,"D"=>"C","L"=>7,"R"=>9},
      9 => {"U"=>9,"D"=>9,"L"=>8,"R"=>9},
      "A" => {"U"=>6,"D"=>"A","L"=>"A","R"=>"B"},
      "B" => {"U"=>7,"D"=>"D","L"=>"A","R"=>"C"},
      "C" => {"U"=>8,"D"=>"C","L"=>"B","R"=>"C"},
      "D" => {"U"=>"B","D"=>"D","L"=>"D","R"=>"D"}
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
