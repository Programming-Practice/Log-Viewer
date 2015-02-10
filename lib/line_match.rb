class LineMatch
  attr_accessor :line_num, :line

  def initialize(line_num,line)
    self.line = line
    self.line_num = line_num
  end

  def to_s
    return "#{line_num} #{line}"
  end
end