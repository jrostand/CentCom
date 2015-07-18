class FeedCategory < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  one_to_many :feeds, key: :category_id

  def validate
    super
    validates_presence [:name]
    validates_unique :name
  end
end
