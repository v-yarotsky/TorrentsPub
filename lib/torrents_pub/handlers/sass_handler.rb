require 'sinatra/base'
require 'sass'

module TorrentsPub
  class Handlers::SassHandler < Sinatra::Base
    set :views, File.join(ROOT, 'stylesheets')

    get '/assets/*.css' do
      filename = params[:splat].shift
      sass filename.to_sym
    end
  end
end

