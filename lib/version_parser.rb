
class VersionParser
  def get_version_from_file filename
  s= File.open(filename)
  s.each_line do |line|
    if line.include?('Version')
      open = line.index '('
      close = line.index ')',open
      return line[open+1,close-open-1]
    end
  end
  end
end