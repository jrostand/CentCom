class Story < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  many_to_one :author
  many_to_one :feed

  many_to_many :tags

  def validate
    super
    validates_presence [:author_id, :title, :content, :url, :published_at]
  end

  def_dataset_method :unread do
    where(read: false).order(Sequel.desc(:published_at))
  end
end
