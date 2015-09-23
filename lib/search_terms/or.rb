require 'search_terms/any'

class Or < Any
  def initialize(term1,term2)
    super([term1,term2])
  end
end