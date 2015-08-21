class Weighing < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  def validate
    super
    validates_presence [:body_fat, :weight]
  end
end
