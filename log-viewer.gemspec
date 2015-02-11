
Gem::Specification.new do |s|
  s.name        = 'pp-log-viewer'
  s.version     = 1.0.0
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Programming Practice'
  s.email       = 'developers@virtualhold.com'
  s.homepage    = 'http://www.virtualhold.com'
  s.summary     = 'VHT Programming Practice Log Viewer'
  s.date        = Time.now.strftime('%Y-%m-%d')

  s.description = <<-EOF
    Log Viewer - VHT Programming Practice
  EOF

  s.files            = Dir['README*']
  s.files           += Dir['{bin,lib}/**/*']
  s.executables      = Dir['bin/*'].collect{|f| File.basename(f)}
  s.require_paths    = ['lib']

  s.required_ruby_version = '>= 2.0.0'

end

