require 'torrents_pub'
require 'sinatra/base'
require 'slim'

module TorrentsPub
  class App < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'assets', 'templates')

    get '/' do
      slim :index
    end
  end
end

