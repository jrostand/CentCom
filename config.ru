require './app.rb'
require 'sidekiq/web'

map '/sidekiq' do
  use Rack::Session::Cookie, secret: 'AWeakCookieSecret'
  run Sidekiq::Web
end

map '/' do
  run Sinatra::Application
end
