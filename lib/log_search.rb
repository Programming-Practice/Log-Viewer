class LogSearch

  def search(log, stringToFind)

    raise IOError,"The log \"#{log}\" does not exist."  unless File.exist? log

    results = Array.new
    line_num = 0

    File.read(log).each_line {|line|
      line_num += 1
      results << LineMatch.new(line_num,line) if line_matches(line,stringToFind)
    }
    return results

  end

  def line_matches(line, stringToFind)
    line.match(stringToFind)
  end

end
