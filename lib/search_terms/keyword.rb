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
class Keyword

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
