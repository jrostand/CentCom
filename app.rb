require './config/initialize'

set :root, __dir__

helpers JsonRender
helpers Partial

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

get '/' do
  @stories = Story.unread.all
  slim :index
end
