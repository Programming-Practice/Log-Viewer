class LogFileFinder

  def initialize(root_log_dir)
    @root_log_dir = root_log_dir
    raise(IOError,"The directory \"#{root_log_dir}\" does not exist.") unless Dir.exist?(root_log_dir)
  end

  def main_output
    Dir.glob("#{@root_log_dir}/**/MainOutputLog*.txt")
  end




end
