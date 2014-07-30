# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/testtask'
#require 'rake/rdoctask'
require 'spree/testing_support/common_rake'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc 'Generates a dummy app for testing'
task :test_app do
    ENV['LIB_NAME'] = 'spree/auth'
      Rake::Task['common:test_app'].invoke("Spree::User")
end

task :default => :test
