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

  def get_call_ids(data, log_file_type)
    call_ids = []
    case log_file_type
      when 'MainOutputLog'
        search(data, ['Interaction Create', 'New Call', 'Start'], 'and').each { |line|
          call_id = (line.to_s.partition('Start|').last).partition('|').first
          call_ids.push(call_id) unless call_ids.include?(call_id)
        }
      when 'MainReportLog'
        search(data, ['New Call\|Interaction Created'], 'and').each { |line|
          call_id = line.to_s.partition('|New Call').first
          call_ids.push(call_id) unless call_ids.include?(call_id)
        }
    end
    call_ids
  end

  def get_number_of_call_ids(log, log_file_type)
    get_call_ids(log, log_file_type).size
  end

end