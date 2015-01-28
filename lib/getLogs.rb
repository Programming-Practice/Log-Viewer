require_relative "helpers"
require_relative "../../Log-Viewer/spec/MainOutputLog"

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

log_path = ARGV[0]

tempMainLogFile = Log_Viewer.new(log_path)

puts tempMainLogFile.display_path.to_s

tempMainLogFile.display_date_folders

tempMainLogFile.display_main_files


