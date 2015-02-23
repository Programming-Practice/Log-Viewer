class Keyword

  module SensitiveSearchStrategy
    def matches?(line)
      line.include? @string
    end
  end

  module InsensitiveSearchStrategy
    def matches?(line)
      line.downcase.include? @string.downcase
    end
  end

  def initialize(string,mode = :sensitive)
    strategize(mode)
    @string = string
  end

  private

  def strategize(mode)
    # capitalize the first letter of the mode
    strategy = mode.slice(0,1).capitalize + mode.slice(1..-1)

    # extend *just this object* with the appropriate strategy module
    # NOTE: if an invalid mode was passed at construction this will raise
    #       a NameError exception
    extend Keyword.const_get("#{strategy}SearchStrategy")
  end
end

#class Keyword

  #def initialize(string,mode = :sensitive)
    #@string = string
    #@mode = mode
  #end

  #def matches?(line)
    ## dynamically call the appropriate private method
    ## NOTE: if an invalid mode was passed at construction this will raise
    ##       a NoMethodError exception
    #send("#{@mode}_match?", line)
  #end

  #private

  #def sensitive_match?(line)
    #line.include? @string
  #end

  #def insensitive_match?(line)
    #line.downcase.include? @string.downcase
  #end
#end
