class LogSearch


  def search(log, stringToFind, operator)

    raise IOError,"The log \"#{log}\" does not exist."  unless File.exist? log

    results = Array.new
    line_num = 0
    File.read(log).each_line {|line|
      line_num += 1
      results << LineMatch.new(line_num,line) if eval(build_code_string(operator, stringToFind))
    }

    results

  end

  def build_code_string(operator, stringToFind)
    code = ' '
    if operator == 'or'
      stringToFind.each_index { |index|
        if index == 0
          code << "line_matches(line, stringToFind[#{index}])"
        else
          code << " || line_matches(line, stringToFind[#{index}])"
        end
      }
    end

    if operator == 'and'
      stringToFind.each_index { |index|
        if index == 0
          code << "line_matches(line, stringToFind[#{index}])"
        else
          code << " && line_matches(line, stringToFind[#{index}])"
        end
      }
    end

    if operator == nil
      stringToFind.each_index { |index|
        if index > 0
          raise IOError,'An operator was not passed for multiple keywords'
        end
        code << "line_matches(line, stringToFind[#{index}])"
      }
    end

    return code
  end



  def line_matches(line, stringToFind)
    line.match(stringToFind)
  end

end
