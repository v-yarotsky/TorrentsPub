require 'sprockets'
require 'torrents_pub'

map '/assets' do
  sprockets = Sprockets::Environment.new

  %w(coffeescripts stylesheets js_templates).each do |dir|
    sprockets.append_path File.join(TorrentsPub::ROOT, 'assets', dir)
  end

  run sprockets
end

map '/' do
  run TorrentsPub::App
end
