require './config/initialize'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end
