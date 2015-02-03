Gem::Specification.new do |s|
  s.name	= 'log-viewer'
  s.version	= '0.0.0'
  s.date	= '2015-02-03'
  s.summary	= 'VHT 8.x Log Viewer'
  s.description = 'Parse and view VHT 8.x log files'
  s.authors	= 'VHT'
  s.email	= 'support@virtualhold.com'
  s.files	= Dir.glob('lib/*.rb')
  s.executables	= ['find_main_output']
  s.homepage	= 'http://virtualhold.com'
  s.license	= 'MIT'
end
