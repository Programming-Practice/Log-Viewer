class LogFileFinder

  def initialize(root_log_dir)
    @root_log_dir = root_log_dir
    raise IOError, "The directory \"#{root_log_dir}\" does not exist." unless Dir.exist?(root_log_dir)
  end

  def main_output
    return @main_output unless @main_output.nil?
    @main_output = Dir.glob(File.join(@root_log_dir,'**','MainOutputLog*.txt'))
  end

  def get_main_output_count
   main_output.size
  end

end
