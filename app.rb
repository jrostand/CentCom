require './config/initialize'

set :root, __dir__

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

get '/' do
  @stories = Story.where(read: false).all
  slim :index
end
