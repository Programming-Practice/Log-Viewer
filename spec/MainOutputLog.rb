class Log_Viewer
  def initialize(path)
    @path = path
    @main_date_folders = get_date_folders
    @main_files = get_main_files(@main_date_folders)
  end

  def get_date_folders
    folders = Dir.entries(@path+"\\Main")
    folders.delete_at(0)
    folders.delete_at(0)
    folders
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
      temp_files = Dir.entries(@path+"\\Main\\"+folder.to_s)
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
    puts "Path: #{@path}"
  end

end

class MainOutputLogFile

end