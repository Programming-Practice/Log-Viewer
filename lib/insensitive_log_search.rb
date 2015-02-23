require 'search_terms/keyword'

class InsensitiveLogSearch < Keyword

  def matches?(line)
    line.include?(/\b#{@string}\b/i)
  end

end