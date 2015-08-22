require './config/boot'
require './config/settings'

CentCom::Settings.load!

Dir['./config/modules/*.rb'].each { |file| require file }

Dir['./models/extensions/*.rb'].each { |file| require file }

Dir['./{lib/helpers,models,routes,workers}/**/*.rb'].each { |file| require file }
