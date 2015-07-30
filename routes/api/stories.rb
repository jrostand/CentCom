post '/api/stories/:id/edit' do |story_id|
  story = Story[story_id]

  begin
    story.update params['story']
    render_json message: 'OK'
  rescue
    render_json error: "Could not update story #{story.id}"
  end
end
