$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "io_ask/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "io_ask"
  s.version     = IoAsk::VERSION
  s.authors     = ["Arly Xiao"]
  s.email       = ["arlyxiao@163.com"]
  s.homepage    = "http://iobuild.github.io"
  s.summary     = "The best ask rails engine in the world"
  s.description = "The best ask rails engine in the world"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  # s.files = `git ls-files`.split("\n")
  # s.test_files = Dir["test/**/*"]


  s.add_development_dependency 'launchy'
  s.add_development_dependency 'rspec-rails', '~> 2.14.0'
  s.add_development_dependency 'capybara', '2.1.0'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency "sqlite3"

  s.add_development_dependency 'factory_girl_rails', '~> 4.4.1'
  s.add_development_dependency 'database_cleaner', '~> 1.0.0'
  s.add_development_dependency 'devise', '3.3.0'
  s.add_development_dependency 'kaminari', '~> 0.15.0'
  s.add_development_dependency 'timecop', '~> 0.6.1'


  s.add_dependency 'rails', '~> 4.0', '<= 4.2'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency 'decorators', '~> 1.0.2'
  s.add_dependency 'mysql2'

  s.add_dependency 'bootstrap-sass', '~> 3.3.1'
  s.add_dependency 'sass-rails', '>= 3.2'
  s.add_dependency 'autoprefixer-rails'
  s.add_dependency 'coffee-rails', '~> 4.0'
  s.add_dependency 'font-awesome-sass'


end
