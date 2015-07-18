require './config/boot'

desc '[Utility task] Load the app environment'
task :environment do
  require './config/initialize'
end

Dir['lib/tasks/*.rake'].each { |file| load file }
