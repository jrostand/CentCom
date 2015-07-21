Sequel.migration do
  change do
    create_join_table story_id: :stories, tag_id: :tags
  end
end
