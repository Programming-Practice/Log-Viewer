begin
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'
  
  task :gem do
    system 'gem build pp-log-viewer.gemspec'
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end
  
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--color --format documentation"
  end
  
  task :default => [:spec,:features,:gem]

rescue LoadError
  # no rspec available
end
