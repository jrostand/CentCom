Sequel.migration do
  change do
    create_table :tags do
      primary_key :id

      String :name, null: false

      Time :created_at
      Time :updated_at
    end
  end
end
