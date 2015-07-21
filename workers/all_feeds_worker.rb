class AllFeedsWorker
  include Sidekiq::Worker

  sidekiq_options queue: :utility

  def perform
    Feed.all.each do |feed|
      FeedReaderWorker.perform_async feed.id
    end
  end
end
