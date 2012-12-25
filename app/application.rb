require 'sinatra/base'
require 'slim'
require 'json'
require 'app/models/torrent'
require 'app/models/trackers'
require 'app/models/tracker'

class Application < Sinatra::Base
  set :views, File.expand_path('../assets/templates')

  # get '/api/trackers', provides: :json do
  #   @trackers = Tracker.all
  #   @trackers.to_json
  # end

  # get '/api/trackers/:id', provides: :json do
  #   @tracker = Tracker.get(params[:id])
  #   if @tracker
  #     @tracker.to_json
  #   else
  #     404
  #   end
  # end

  # post '/api/trackers' do
  #   tracker_params = JSON.parse(request.body.read.to_s)
  #   puts tracker_params.inspect
  #   if tracker = Tracker.create(tracker_params)
  #     tracker.to_json
  #   else
  #     400
  #   end
  # end

  # put '/api/trackers/:id' do
  #   tracker = Tracker.get(params[:id])
  #   tracker_params = JSON.parse(request.body.read.to_s)
  #   puts tracker_params.inspect
  #   if tracker.update(tracker_params)
  #     tracker.to_json
  #   else
  #     400
  #   end
  # end

  post '/api/categories' do
    category_params = JSON.parse(request.body.read.to_s)
    puts category_params.inspect
    if category = Category.create(category_params)
      category.to_json
    else
      400
    end
  end

  put '/api/categories/:id' do
    category = Category.get(params[:id])
    category_params = JSON.parse(request.body.read.to_s)
    puts category_params.inspect
    if category.update(category_params)
      category.to_json
    else
      400
    end
  end

  get '/api/torrents' do
    Torrent.all.to_json
  end

  post '/api/refresh_torrents' do
    begin
      trackers.each(&:fetch_torrents)
      ''
    rescue => e
      status 500
      e.message
    end
  end

  get '*' do
    @torrents = Torrent.all
    @categories = Category.all
    trackers
    slim :index, :torrents => @torrents
  end

  private

  def trackers
    @trackers ||= Trackers.new(YAML.load(File.read(File.expand_path('../config/trackers.yml', __FILE__))))
  end
end

