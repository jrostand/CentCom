get '/api/weighings' do
  render_json Weighing.recent.all.sort_by(&:id)
end

post '/api/weighings/:token' do |token|
  if token == CentCom::Settings.incoming_token
    begin
      data = json_body(request)
      Weighing.create data['weighing']
      render_json message: 'Weigh-in created'
    rescue
      status 400
      render_json error: 'Unable to create weigh-in'
    end
  else
    status 403
    render_json error: 'Invalid token'
  end
end
