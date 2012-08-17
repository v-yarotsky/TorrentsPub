require 'torrents_pub'
require 'sinatra/base'
require 'slim'
require 'json'
require 'data_mapper'
require 'torrents_pub/torrent'
require 'torrents_pub/tracker'

DataMapper.setup(:default, 'sqlite:////Users/vladimiryarotsky/Projects/torrents_pub/qux.db')
DataMapper.auto_upgrade!

module TorrentsPub
  class App < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'assets', 'templates')

    get '/' do
      @torrents = Torrent.all
      slim :index, :torrents => @torrents
    end

    get '/trackers/:id' do
      @tracker = Tracker.get(params[:id])
      @tracker.to_json
    end
  end
end

