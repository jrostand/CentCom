class Feed < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  many_to_one :feed_category, key: :category_id

  def validate
    super
    validates_presence [:category_id, :name, :feed_url, :url]
    validates_unique :name
  end
end
