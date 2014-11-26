namespace :io_ask do
  desc "Generates a dummy app for testing"
  task :dummy_app => [:setup_dummy_app, :migrate_dummy_app]

  task :setup_dummy_app do
    require 'rails'
    require 'io_ask'
    require File.expand_path('../../generators/io_ask/dummy/dummy_generator', __FILE__)

    IoAsk::DummyGenerator.start %w(--quiet)
  end

  task :migrate_dummy_app do
    ENV['RAILS_ENV'] = 'test'
    Dir.chdir(IoAsk::Engine.root + "spec/dummy") do
      system("bundle exec rake io_ask:install:migrations db:drop db:create db:migrate db:seed")
    end
  end
end
