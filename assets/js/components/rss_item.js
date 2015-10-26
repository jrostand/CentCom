var RssItem = React.createClass({
  handleMarkRead: function(event) {
    event.preventDefault();

    $.ajax({
      url: '/api/stories/' + this.props.data.id,
      method: 'patch',
      dataType: 'json',
      data: {
        story: {
          read: true
        }
      }
    });

    this.props.onMarkRead();
  },

  storyContent: function() {
    return { __html: this.props.data.content };
  },

  render: function() {
    return <div className="rss-item">
      <p className="rss-title">
        [{this.props.data.feed}] {this.props.data.title}
      </p>

      <div className="rss-body">
        <p className="rss-article" dangerouslySetInnerHTML={this.storyContent()}></p>
        <p className="rss-links">
          <a href="#" className="mark-read" onClick={this.handleMarkRead}>Mark read</a>
          <a href={this.props.data.url} className="read-more" target="_blank">Read more</a>
        </p>
      </div>
    </div>;
  }
});
