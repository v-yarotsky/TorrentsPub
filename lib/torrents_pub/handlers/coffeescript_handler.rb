require 'sinatra/base'
require 'coffee_script'

module TorrentsPub
  class Handlers::CoffeescriptHandler < Sinatra::Base
    set :views, File.join(TorrentsPub::ROOT, 'coffeescripts')

    get '/assets/*.js' do
      filename = params[:splat].shift
      coffee filename.to_sym
    end
  end
end

