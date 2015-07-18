module CentCom
  module Validations
    def self.included(base)
      base.plugin :validation_helpers
    end
  end
end
