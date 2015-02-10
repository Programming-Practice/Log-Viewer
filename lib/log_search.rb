
class LogSearch

  def search(log, stringToFind)

    raise IOError,"The log \"#{log}\" does not exist."  unless File.exist? log

    results = Array.new
    line_num = 0

    File.read(log).each_line {|line|
      line_num += 1
      results << "#{line_num} " + line if line.match(stringToFind)
    }
    return results

  end

end