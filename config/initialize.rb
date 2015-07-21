require './config/boot'
require './config/settings'

CentCom::Settings.load!

Dir['./config/modules/*.rb'].each do |file|
  require file
end

Dir['./{models,workers}/**/*.rb'].each { |model| require model }
