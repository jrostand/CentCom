post '/api/feeds/refresh' do
  AllFeedsWorker.perform_async
  render_json message: 'OK'
end

post '/api/feeds/:id/refresh' do |feed_id|
  FeedReaderWorker.perform_async feed_id
  render_json message: 'OK'
end
