require 'win32/registry'

class FileHelper
   def read_vht_registry_for(registry_value)
    Win32::Registry::HKEY_LOCAL_MACHINE.open('Software\Virtual Hold') do |reg|
      reg_typ, reg_val = reg.read(registry_value)
      return reg_val
    end
    return ''
  end

  def get_installation_location
    read_vht_registry_for('InstallationLocation')
  end
end