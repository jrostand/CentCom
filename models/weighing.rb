class Weighing < Sequel::Model
  include CentCom::Timestamps
  include CentCom::Validations

  def validate
    super
    validates_presence [:body_fat, :weight]
  end

  def_dataset_method :recent do
    order(Sequel.desc(:created_at)).limit(7)
  end

  def to_json(options = nil)
    {
      day_label: created_at.strftime('%a').downcase,
      body_fat: body_fat,
      weight: weight
    }.to_json
  end
end
