require 'log_search'

class InsensitiveLogSearch < LogSearch

  def line_matches(line, stringToFind)
    line.match(/\b#{stringToFind}\b/i)
  end

end