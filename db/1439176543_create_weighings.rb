Sequel.migration do
  change do
    create_table :weighings do
      primary_key :id

      Float :body_fat, null: false
      Float :weight, null: false

      Time :created_at
      Time :updated_at
    end
  end
end
