module CentCom
  module Timestamps
    def before_create
      self.created_at = Time.now.utc
      super
    end

    def before_save
      self.updated_at = Time.now.utc
      super
    end
  end
end
