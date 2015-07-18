require './app.rb'

map '/assets' do
  sprockets = Sprockets::Environment.new
  sprockets.append_path File.join('assets', 'css')
  sprockets.append_path File.join('assets', 'img')
  sprockets.append_path File.join('assets', 'js')
  run sprockets
end

map '/' do
  run Sinatra::Application
end
