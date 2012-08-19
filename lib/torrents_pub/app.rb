require 'torrents_pub'
require 'sinatra/base'
require 'slim'
require 'json'
require 'torrents_pub/torrent'
require 'torrents_pub/tracker'

module TorrentsPub
  class App < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'assets', 'templates')

    get '/trackers', provides: :json do
      @trackers = Tracker.all
      @trackers.to_json
    end

    get '/trackers/:id', provides: :json do
      @tracker = Tracker.get(params[:id])
      if @tracker
        @tracker.to_json
      else
        404
      end
    end

    post '/trackers/:id' do
      tracker = Tracker.first_or_create(id: params[:id])
      if tracker.update(params[:tracker])
        tracker.to_json
      else
        400
      end
    end

    get '*' do
      @torrents = Torrent.all
      @tracker_types = [:torrents_by, :rutracker_org]
      slim :index, :torrents => @torrents
    end

  end
end

