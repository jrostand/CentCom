class Author < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  one_to_many :stories

  def validate
    super
    validates_presence [:name]
    validates_unique :name
  end
end
