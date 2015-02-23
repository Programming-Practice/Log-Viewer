class Keyword
  def initialize(string,mode = :sensitive)
    @mode = mode
    if @mode == :insensitive
      @string = string.downcase
    else
      @string = string
    end
  end
  def matches?(line)
    if @mode == :insensitive
      line.downcase.include? @string
    else
      line.include? @string
    end
  end
end
