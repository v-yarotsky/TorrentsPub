require 'torrents_pub'
require 'sinatra/base'
require 'slim'
require 'json'
require 'torrents_pub/torrent'
require 'torrents_pub/tracker'

module TorrentsPub
  class App < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'assets', 'templates')

    get '/api/trackers', provides: :json do
      @trackers = Tracker.all
      @trackers.to_json
    end

    get '/api/trackers/:id', provides: :json do
      @tracker = Tracker.get(params[:id])
      if @tracker
        @tracker.to_json
      else
        404
      end
    end

    post '/api/trackers' do
      tracker_params = JSON.parse(request.body.read.to_s)
      puts tracker_params.inspect
      if tracker = Tracker.create(tracker_params)
        tracker.to_json
      else
        400
      end
    end

    put '/api/trackers/:id' do
      tracker = Tracker.get(params[:id])
      tracker_params = JSON.parse(request.body.read.to_s)
      puts tracker_params.inspect
      if tracker.update(tracker_params)
        tracker.to_json
      else
        400
      end
    end

    get '/api/torrents' do
      Torrent.all.to_json
    end

    post '/api/refresh_torrents' do
      begin
        Tracker.all.each(&:fetch_torrents)
        ''
      rescue => e
        status 500
        e.message
      end
    end

    get '*' do
      @torrents = Torrent.all
      @tracker_types = Tracker.available_types
      slim :index, :torrents => @torrents
    end

  end
end

