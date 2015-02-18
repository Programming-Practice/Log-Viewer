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

  # This function is for MainOutPutFiles only
  def number_of_call_ids(log)
    call_ids = []
    File.read(log).each_line { |line|
      #TODO Change so that lines searched come from the search function (passing in the array ['Interaction Created','New Call','Start'])
      if (line_matches(line,"Interaction Created") and line_matches(line,"New Call") and line_matches(line,"Start"))
        call_id = (line.partition('Start|').last).partition('|').first
        call_ids.push(call_id) unless call_ids.include?(call_id)
      end
    }
    call_ids.size
  end

end