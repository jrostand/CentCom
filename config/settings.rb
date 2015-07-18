module CentCom
  class Settings
    def self.load!
      settings_json = File.read 'config/settings.json'
      settings = JSON.parse settings_json

      settings.each do |key, val|
        define_singleton_method key do
          val
        end
      end
    end
  end
end
