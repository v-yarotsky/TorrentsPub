# encoding: utf-8
require 'rubygems'
require 'bundler'
require 'jasmine-headless-webkit'
require 'rack'
require 'data_mapper'
$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'torrents_pub/app'
require 'torrents_pub/environment'

begin
  Bundler.require(:default, :development)
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
  t.jasmine_config = 'spec/backbone/support/jasmine.yml'
end

task :server do
  server = Rack::Server.new
  server.options.merge! :config => 'config.ru'
  server.start
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  include TorrentsPub
  IRB.start
end

task :fetch_torrents => :environment do
  trackers ||= TorrentsPub::Trackers.new(YAML.load(File.read(File.expand_path('../config/trackers.yml', __FILE__))))
  trackers.each(&:fetch_torrents)
end

task :environment do
  TorrentsPub::Environment.setup
end

task :default => :spec


