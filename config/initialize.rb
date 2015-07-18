require './config/boot'
require './config/settings'

CentCom::Settings.load!

Dir['./config/modules/*.rb'].each do |file|
  require file
end

Dir['./models/*.rb'].each { |model| require model }
