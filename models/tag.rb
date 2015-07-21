class Tag < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  many_to_many :stories

  def validate
    super
    validates_presence [:name]
    validates_unique :name
  end
end
