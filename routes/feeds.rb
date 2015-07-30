get '/feeds' do
  @categories = FeedCategory.eager(:feeds).order(Sequel.asc(:name)).all

  slim :'feeds/index'
end

get '/feeds/new' do
  @categories = FeedCategory.order(Sequel.asc(:name)).all
  @feed = Feed.new

  slim :'feeds/new'
end

post '/feeds/new' do
  @feed = Feed.new params['feed']

  begin
    @feed.save
    FeedReaderWorker.perform_async @feed.id

    redirect '/feeds'
  rescue
    @categories = FeedCategory.order(Sequel.asc(:name)).all

    slim :'feeds/new', locals: { form_errors: @feed.errors }
  end
end

get '/feeds/:id/edit' do |feed_id|
  @categories = FeedCategory.order(Sequel.asc(:name)).all
  @feed = Feed[feed_id]

  slim :'feeds/edit'
end

post '/feeds/:id/edit' do |feed_id|
  @feed = Feed[feed_id]

  begin
    @feed.update params['feed']
    redirect '/feeds'
  rescue
    @categories = FeedCategory.order(Sequel.asc(:name)).all
    slim :'feeds/edit', locals: { form_errors: @feed.errors }
  end
end

post '/feeds/refresh' do
  AllFeedsWorker.perform_async
  render_json message: 'OK'
end

post '/feeds/:id/refresh' do |feed_id|
  FeedReaderWorker.perform_async feed_id
  render_json message: 'OK'
end
