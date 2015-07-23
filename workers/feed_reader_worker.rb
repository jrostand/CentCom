class FeedReaderWorker
  include Sidekiq::Worker

  sidekiq_options queue: :rss

  def perform(id)
    feed = Feed[id]

    latest_story_time = Time.parse feed.latest_story.published_at

    stories = feed_stories feed

    stories.each do |article|
      next if article.published <= latest_story_time

      author_id = Author.find_or_create(name: article.author).id

      content = extract_story_content article

      Story.create(
        feed_id: id,
        author_id: author_id,
        title: article.title,
        content: expand_absolute_urls(content, feed.url),
        published_at: article.published,
        url: article.url
      )
    end
  end

  private

  def expand_absolute_urls(content, base_url)
    doc = Nokogiri::HTML.fragment(content)
    abs_re = URI::DEFAULT_PARSER.regexp[:ABS_URI]

    [["a", "href"], ["img", "src"], ["video", "src"]].each do |tag, attr|
      doc.css("#{tag}[#{attr}]").each do |node|
        url = node.get_attribute(attr)
        unless url =~ abs_re
          begin
            node.set_attribute(attr, URI.join(base_url, url).to_s)
          rescue URI::InvalidURIError
          end
        end
      end
    end

    doc.to_html
  end

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
