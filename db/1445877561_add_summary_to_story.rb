Sequel.migration do
  change do
    alter_table :stories do
      add_column :summary, String
    end
  end
end
