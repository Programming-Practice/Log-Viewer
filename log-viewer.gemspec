$:.push File.join(File.dirname(__FILE__), 'lib')


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

  s.files            = Dir['README*', 'LICENSE*', 'CHANGELOG*']
  s.files           += Dir['{bin,lib}/**/*', 'config/**/*.yml']
  s.files           += Dir['fabricators/**/*.rb', 'features/**/*.rb']
  s.files           += Dir['spec/{shared,support}/**/*.rb']
  s.executables      = Dir['bin/*'].collect{|f| File.basename(f)}
  s.extra_rdoc_files = ['README.md']
  s.extra_rdoc_files = Dir['README*', 'LICENSE*', 'CHANGELOG*']
  s.require_paths    = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'bundler', '~> 1.7.2'

  # deveopment
  s.add_development_dependency 'rake', '~> 10.3.2'

  # test
  s.add_development_dependency 'rspec', '= 2.14.1'

end
