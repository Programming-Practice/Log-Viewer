require_relative "helpers"

# From Console

v1 = ARGV[0]

puts v1

#
# Reg_path = "SOFTWARE\\Wow6432Node\\Virtual Hold"
# Log_key = "MainLogFilePath"
#
# log_path = RegistryHelpers.read_value(Reg_path, Log_key)
# puts "Your log file path is: #{log_path}\n"
#
# main_date_folders = Dir.entries(log_path+"\\Main")
# main_date_folders.delete_at(0)
# main_date_folders.delete_at(0)
# puts "\n"
# puts "Main Output Folders:\n"
# puts "\t"+main_date_folders[0].to_s
#
# main_files = []
#
# puts "\n"
# puts "Main Output Files:\n"
# main_date_folders.each do |folder|
#   temp_files = Dir.entries(log_path+"\\Main\\"+folder.to_s)
#   temp_files.delete_at(0)
#   temp_files.delete_at(0)
#   main_files += temp_files
# end
#
# main_files.each do |filename|
#     puts "\t"+filename.to_s
# end
