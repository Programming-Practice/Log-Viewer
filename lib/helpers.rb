require 'Win32/registry'

module RegistryHelpers
  extend self
  def read_value path, key
    puts "LOG: Finding registry key #{key} in #{path}..."
    begin
      Win32::Registry::HKEY_LOCAL_MACHINE.open(path) do |reg|
        reg[key].to_s
      end
    rescue
      raise "ERROR: Cannot find registry path: #{path}"
    end
  end
end
