require 'torrents_pub'
require 'sinatra/base'
require 'slim'
require 'pry'
require 'json'

module TorrentsPub
  class App < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'assets', 'templates')

    get '/' do
      @torrents = [
        { id: 1, title: 'Foo', size: "300 MB", seeders: 400, category: 'Movies', url: 'http://example.com/example.torrent', tracker: 'Example.com' },
        { id: 2, title: 'Bar', size: "200 MB", seeders: 500, category: 'Series', url: 'http://example.com/example2.torrent', tracker: 'Example.com' },
        { id: 3, title: 'Baz', size: "400 MB", seeders: 200, category: 'Movies', url: 'http://foobar.com/example3.torrent', tracker: 'Foobar.com' }
      ]
      slim :index, :torrents => @torrents
    end
  end
end

