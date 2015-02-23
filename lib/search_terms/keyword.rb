class Keyword
  def initialize(string,mode = :sensitive)
    @mode = mode
    if @mode == :insensitive
    then
      @string = string.downcase
    else
      @string = string
    end
  end
  def matches?(line)
    if @mode == :insensitive
    then
      line.downcase.include? @string
    else
      line.include? @string
    end
  end
end
