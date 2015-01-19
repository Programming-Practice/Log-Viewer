require_relative "helpers"

log_path = "SOFTWARE\\Wow6432Node\\Virtual Hold"
log_key = "MainLogFilePath"
value = RegistryHelpers.read_value(log_path, log_key)
puts "Your log file path is: #{value}"
