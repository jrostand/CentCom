class FeedReaderWorker
  include Sidekiq::Worker

  sidekiq_options queue: :rss

  def perform(id)
    stories = feed_stories Feed[id]

    stories.each do |article|
      author_id = Author.find_or_create(name: article.author).id

      content = extract_story_content article

      Story.create(
        title: article.title,
        content: content,
        author_id: author_id,
        published_at: article.published,
        url: article.url
      )
    end
  end

  private

  def extract_story_content(article)
    content = article.content || article.summary
    sanitize content
  end

  def feed_stories(feed)
    Feedjira::Feed.fetch_and_parse(feed.feed_url).entries
  end

  def sanitize(html)
    Loofah.fragment(html.gsub(/<wbr\s*>/i, ''))
          .scrub!(:prune)
          .scrub!(:unprintable)
          .to_s
  end
end
