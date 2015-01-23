

class Log_search

  def search(log, stringToFind)
    if not File.exist?(log)
      raise IOError,"The log \"#{log}\" does not exist."
    end
      print log

    File.open('output.txt', 'w') do |fileOut|
      fileOut.puts File.foreach(log).grep(/#{stringToFind}/)
    end

  end


end

temp = Log_search.new

temp.search("MainOutputLog_00001.txt" , "Utilities")