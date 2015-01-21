def all_main_output_logs(root_dir_name)
  []
end

class LogFileFinder

  def initialize(root_log_dir)
    @root_log_dir = root_log_dir
    if not Dir.exist?(root_log_dir)
      raise IOError,"The directory \"#{root_log_dir}\" does not exist."
    end
  end

  def main_output
    Dir.glob("#{@root_log_dir}/**/MainOutputLog*.txt")
  end




end
#Dir.glob("C:\Projects\Log-Viewer\TestLogs\VHLogs\**\MainOutputLog*.txt")