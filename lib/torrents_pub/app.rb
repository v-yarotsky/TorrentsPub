require 'torrents_pub'
require 'sinatra/base'
require 'torrents_pub/handlers'

module TorrentsPub
  class App < Sinatra::Base
    use Handlers::CoffeescriptHandler
    use Handlers::SassHandler
  end
end

TorrentsPub::App.run!

