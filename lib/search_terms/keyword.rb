class Keyword
  def initialize(string,mode = :sensitive)
    @mode = mode
    @string = string
  end
  def matches?(line)
    if @mode == :insensitive
    then
      line =~ /#{@string}/i
    else
      line.include? @string
    end
  end
end
