# For complex strategies, this is the approach I would probably take
# for production code. It's a very Ruby-centric approach to the
# classic Gang of Four strategy pattern.
#
# Adding a new strategy simply means adding a new module with the necessary
# method. The strategy modules could be defined just about anywhere--they don't
# have to be internal to the class. Putting each strategy in a separate code
# file would keep the code base much cleaner.
#
# Another advantage to this approach is that it pairs nicely with RSpec's
# shared examples (aka "behave like"). The shared examples would be used
# to verify that each strategy implements the necessary API.
#
# What makes this approach very Ruby-ish is the dynamic inclusion of
# the strategy module. In strongly-typed languages like Java and C#
# we need to create an instance of a strategy object and pass it into
# the constructor. That approach would also require a class hierarchy
# to enforce type safety. Since Ruby is duck-typed, class hierarchies
# of that nature simply don't work. This approach allows us to pass in
# a symbol as our strategy then map it to the appropriate implementation.
#
# - Jerry
#
# @see [strategy pattern](http://en.wikipedia.org/wiki/Strategy_pattern)
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

# This is the approach I would most likely use in production code, so
# long as the methods remain small. Adding a new strategy is done
# simply by adding new methods with names that follow the pattern.
# Those methods could even be made class methods (each taking two
# parameters) which would increase the utility of the class.
#
# Another advantage of this approach is that it uses the least amount
# of "magic" of all these approaches. Every Rubyist should be familiar
# with the `send` and `respond_to?` methods. These methods are at the
# core of Ruby's duck-typing.
#
# We use dynamic method dispatch via `send` *all the time* in Navigator.
#
# - Jerry
#
# @see [Object#respond_to?](http://ruby-doc.org/core-2.2.0/Object.html#method-i-respond_to-3F)
# @see [Object#send](http://ruby-doc.org/core-2.2.0/Object.html#method-i-send)
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

class KeywordByMethodAlias

  def initialize(string, mode: :sensitive)
    @string = string

    # get this object's singleton class (aka Eigenclass)
    metaclass = class << self; self; end

    # define the matches? method for *this object only*
    metaclass.send(:alias_method, :matches?, "#{mode}_match?")
    metaclass.send(:public, :matches?)

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
