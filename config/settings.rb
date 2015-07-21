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

    def self.method_missing(name, *args, &block)
      raise SettingUndefinedError, "Tried to fetch #{name} from settings but it was undefined"
    end

    def initialize
      raise NoMethodError, "This class is not designed to be instantiated"
    end
  end

  class SettingUndefinedError < NoMethodError; end
end
