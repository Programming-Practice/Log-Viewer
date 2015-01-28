class LogFileFinder

  def initialize(root_log_dir)
    @root_log_dir = root_log_dir
    if not Dir.exist?(root_log_dir)
      raise IOError,"The directory \"#{root_log_dir}\" does not exist."
    else
      @main_date_folders = get_date_folders
      if @main_date_folders != nil
        @main_files = get_main_files(@main_date_folders)
      end

    end
  end

  def main_output
    Dir.glob("#{@root_log_dir}/**/MainOutputLog*.txt")
  end






  def get_date_folders
    if Dir.exist?(@root_log_dir+"/Main")
      folders = Dir.entries(@root_log_dir+"/Main")
      folders.delete_at(0)
      folders.delete_at(0)
      folders
    end

  end

  def display_date_folders
    puts "Main Output Folders:\n"
    @main_date_folders.each do |folder|
      puts "\t"+folder.to_s
    end
  end

  def get_main_files(folders)
    puts "\n"
    files = []
    folders.each do |folder|
      temp_files = Dir.entries(@root_log_dir+"\\Main\\"+folder.to_s)
      temp_files.delete_at(0)
      temp_files.delete_at(0)
      files += temp_files
    end
    files
  end

  def display_main_files
    puts "Main Output Files:\n"
    @main_files.each do |filename|
      puts "\t"+filename.to_s
    end
  end

  def display_path
    puts "Path: #{@root_log_dir}"
  end





end
