class All
  def initialize(list_of_terms)
    @list = list_of_terms
  end
  def matches?(line)
    @list.all? {|search_term|
      search_term.matches?(line)
    }
  end
end