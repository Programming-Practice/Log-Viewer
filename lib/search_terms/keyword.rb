class Keyword
  def initialize(string)
    @string = string
  end
  def matches?(line)
    line.include?(@string)
  end
end