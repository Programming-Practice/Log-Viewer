
class VersionParser
  def get_version_from_file filename

    raise IOError,"The log \"#{filename}\" is not a MainOutput log file." unless filename.include? 'MainOutputLog_'
    raise IOError,"The log \"#{filename}\" does not exist." unless File.exist? filename

    file = File.open(filename)
    file.each_line do |line|
      if line.include?('Version')
        openParen = line.index '('
        closeParen = line.index ')', openParen
        return line[openParen + 1, closeParen - openParen - 1]
      end
    end
  end
end