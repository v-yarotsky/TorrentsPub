$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'sprockets'
require 'temple'
require 'coffee_script'
require 'slim'
require 'skim'
require 'torrents_pub'
require 'torrents_pub/environment'

map '/assets' do
  sprockets = Sprockets::Environment.new

  %w(backbone stylesheets vendor).each do |dir|
    sprockets.append_path File.join(TorrentsPub::ROOT, 'assets', dir)
  end

  run sprockets
end

TorrentsPub::Environment.setup

map '/' do
  run TorrentsPub::App
end
