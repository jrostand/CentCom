Sequel.migration do
  change do
    create_table :feeds do
      primary_key :id
      foreign_key :category_id, :feed_categories

      String :name, null: false
      String :feed_url, null: false
      String :url, null: false

      Time :created_at
      Time :updated_at
    end
  end
end
