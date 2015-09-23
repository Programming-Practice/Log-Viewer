require 'search_terms/all'

class And < All
  def initialize(term1,term2)
    super([term1,term2])
  end
end