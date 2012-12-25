$:.unshift File.join(File.dirname(__FILE__), 'lib')
$:.unshift File.join(File.dirname(__FILE__))
require 'sprockets'
require 'coffee_script'
require 'skim'
require 'app/environment'

map '/assets' do
  sprockets = Sprockets::Environment.new

  %w(backbone stylesheets vendor).each do |dir|
    sprockets.append_path File.expand_path("../app/assets/#{dir}", __FILE__)
  end

  run sprockets
end

TorrentsPub::Environment.setup

map '/' do
  run TorrentsPub::Application
end
