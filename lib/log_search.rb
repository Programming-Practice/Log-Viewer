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

  def number_of_call_IDs(log)
    line_num = 0
    File.read(log).each_line {|line|
      line_num += 1
      if (line_matches(line,"Interaction Created") and line_matches(line,"New Call") and line_matches(line,"Start"))
        {
          # split string => keep everything after "Start|"
          # split string again => keep eveyrthing before "|"
          # Add to call ID list (if not already in list)
        }
      end
    }
  end

end



2015-01-21 09:54:38.531|INFO|CVHTCall::OnChange|Start|V0002000000000221012015095438531|NULL|New Call| [Interaction Created]|1aa4
2015-01-21 09:54:38.531|Info|CCall::Change|CHANGE_DEVICES|No Device found|V0002000000000221012015095438531|State|New Call|2015-01-21 09:54:38.531|1aa4
2015-01-21 09:54:38.532|Info|CCall::Change|CHANGE_DEVICES|No Device found|V0002000000000221012015095438531|State|Interaction Created|2015-01-21 09:54:38.531|1aa4
2015-01-21 09:54:38.532|CCallStateTimerManager::StartCallStateTimer|CreateTimerQueueTimer succeeded|HANDLE = 9271992|CallId = V0002000000000221012015095438531|CALLINFO Value = Interaction Expired|Reason = Interaction Expired|Timeout = 900000|1aa4
2015-01-21 09:54:38.532|INFO|CVHTCall::OnChange|State Change|V0002000000000221012015095438531| NULL -> (New Call) -> Interaction Created|1aa4
2015-01-21 09:54:38.532|INFO|VHTCall|OnChange|End|V0002000000000221012015095438531|Interaction Created|New Call| [Interaction Created]|1aa4