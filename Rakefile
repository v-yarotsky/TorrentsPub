# encoding: utf-8
require 'rubygems'
require 'bundler'
require 'jasmine-headless-webkit'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/lib/**/*_spec.rb'
end

Jasmine::Headless::Task.new('jasmine') do |t|
  t.colors = true
  t.keep_on_error = true
  t.jasmine_config = 'spec/coffeescripts/support/jasmine.yml'
end

task :default => :spec


