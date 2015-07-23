class Feed < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  one_to_many :stories

  many_to_one :feed_category, key: :category_id

  def latest_story
    Story.where(feed_id: self.id).order(Sequel.desc(:published_at)).limit(1).first
  end

  def validate
    super
    validates_presence [:category_id, :name, :feed_url, :url]
    validates_unique :name
  end
end
