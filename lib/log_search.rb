class LogSearch


  def search(log, keyword)

    raise IOError,"The log \"#{log}\" does not exist."  unless File.exist? log

    results = Array.new
    line_num = 0
    File.read(log).each_line {|line|
      line_num += 1
      results << LineMatch.new(line_num,line) if keyword.matches?(line)
    }
    results

  end


  def line_matches(line, stringToFind)
    line.match(stringToFind)
  end

  def get_call_ids(data, log_file_type)
    call_ids = []
    case log_file_type
      when 'MainOutputLog'
        search(data, All.new([Keyword.new('Interaction Created'), Keyword.new('New Call'), Keyword.new('Start')])).each { |line|
          call_id = (line.to_s.partition('Start|').last).partition('|').first
          call_ids.push(call_id) unless call_ids.include?(call_id)
        }
      when 'MainReportLog'
        search(data, Keyword.new('New Call\|Interaction Created')).each { |line|
          call_id = line.to_s.partition('|New Call').first
          call_ids.push(call_id) unless call_ids.include?(call_id)
        }
      else
        raise IOError, "The file type \"#{log_file_type}\" is invalid"
    end
    call_ids
  end

  def get_number_of_call_ids(log, log_file_type)
    get_call_ids(log, log_file_type).size
  end

end