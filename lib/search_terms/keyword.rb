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

  # classic options-hash approach to optional arguments
  # works on all commonly used Ruby versions
  def initialize(string, opts = {})
    mode = opts.fetch(:mode, :sensitive) # the fetch method lets us set a default
    strategize!(mode)
    @string = string
  end

  private

  def strategize!(mode)
    # capitalize the first letter of the mode
    strategy = mode.slice(0,1).capitalize + mode.slice(1..-1)

    # extend *just this object* with the appropriate strategy module
    extend self.class.const_get("#{strategy}SearchStrategy")

  rescue NameError
    raise ::ArgumentError.new(":#{mode} is not a valid strategy")
  end
end

class KeywordUsingSend

  # using keyword arguments for optional parameters
  # NOTE: Only works with Ruby 2.0 and newer (which JRuby does not support yet)
  def initialize(string, mode: :sensitive)
    @strategy = validate_strategy!(mode)
    @string = string
  end

  def matches?(line)
    send(@strategy, line)
  end

  private

  def validate_strategy!(mode)
    strategy = "#{mode}_match?".to_sym
    unless respond_to?(strategy, true)
      raise ::ArgumentError.new(":#{mode} is not a valid strategy")
    end
    strategy
  end

  def sensitive_match?(line)
    line.include? @string
  end

  def insensitive_match?(line)
    line.downcase.include? @string.downcase
  end
end

class KeywordUsingLambdas

  STRATEGIES = {
    sensitive: ->(string, line){ line.include?(string) },
    insensitive: ->(string, line){ line.downcase.include?(string.downcase) },
  }

  def initialize(string, mode: :sensitive)
    @strategy = STRATEGIES[mode]
    raise ::ArgumentError.new(":#{mode} is not a valid strategy") unless @strategy
    @string = string
  end

  def matches?(line)
    @strategy.call(@string, line)
  end
end

class KeywordByDefineMethod

  def initialize(string, mode: :sensitive)
    @string = string

    # get an object representing the delegate method
    strategy = self.method("#{mode}_match?")

    # get this object's singleton class (aka Eigenclass)
    metaclass = class << self; self; end

    # define the matches? method for *this object only*
    metaclass.send(:define_method, :matches?, &strategy)

  rescue NameError
    raise ::ArgumentError.new(":#{mode} is not a valid strategy")
  end

  private

  def sensitive_match?(line)
    line.include? @string
  end

  def insensitive_match?(line)
    line.downcase.include? @string.downcase
  end
end

class KeywordWithBlock

  def initialize(string, &block)
    raise ArgumentError.new('no block given') unless block_given?
    @string = string
    @strategy = block
  end

  def matches?(line)
    @strategy.call(@string, line)
  end
end
