class FeedReaderWorker
  include Sidekiq::Worker

  sidekiq_options queue: :rss

  def perform(id)
    feed = Feed[id]

    latest_story_time = if feed.latest_story
                          Time.parse feed.latest_story.published_at
                        else
                          Time.parse '2000-01-01 00:00:00Z'
                        end

    stories = feed_stories feed

    stories.each do |article|
      next if article.published <= latest_story_time

      author_id = if article.author
                    Author.find_or_create(name: article.author).id
                  else
                    Author.find_or_create(name: feed.name).id
                  end

      content = extract_story_content article

      Story.create(
        feed_id: id,
        author_id: author_id,
        title: article.title,
        content: expand_absolute_urls(content, feed.url),
        summary: article.summary,
        published_at: article.published,
        url: article.url || feed.url
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
