Sequel.migration do
  change do
    create_table :stories do
      primary_key :id
      foreign_key :author_id, :authors
      foreign_key :feed_id, :feeds

      String :title, null: false
      String :content, null: false
      String :url, null: false
      String :published_at, null: false

      FalseClass :read, default: false

      Time :created_at
      Time :updated_at
    end
  end
end
