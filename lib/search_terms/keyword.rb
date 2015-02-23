class Keyword

  def initialize(string,mode = :sensitive)
    @string = string
    @mode = mode
  end

  def matches?(line)
    # dynamically call the appropriate private method
    # NOTE: if an invalid mode was passed at construction this will raise
    #       a NoMethodError exception
    send("#{@mode}_match?", line)
  end

  private

  def sensitive_match?(line)
    line.include? @string
  end

  def insensitive_match?(line)
    line.downcase.include? @string.downcase
  end
end
