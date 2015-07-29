get '/categories' do
  @categories = FeedCategory.order(Sequel.asc(:name)).all
  slim :'categories/index'
end

get '/categories/new' do
  @category = FeedCategory.new
  slim :'categories/new'
end

post '/categories/new' do
  @category = FeedCategory.new params['category']
  begin
    @category.save
    redirect '/categories'
  rescue
    slim :'categories/new', locals: { form_errors: @category.errors }
  end
end

get '/categories/:id/edit' do |category_id|
  @category = FeedCategory[category_id]
  slim :'categories/edit'
end

post '/categories/:id/edit' do |category_id|
  @category = FeedCategory[category_id]
  begin
    @category.update params['category']
    redirect '/categories'
  rescue
    slim :'categories/edit', locals: { form_errors: @category.errors }
  end
end
