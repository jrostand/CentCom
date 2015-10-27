var RssReader = React.createClass({
  getInitialState: function() {
    return {stories: []};
  },

  handleRefresh: function(event) {
    event.preventDefault();

    var _this = this;

    $.ajax({
      url: '/api/feeds/refresh',
      method: 'post',
      success: function(_) {
        _this.fetchStories();
      }
    });
  },

  handleMarkRead: function() {
    this.fetchStories();
  },

  fetchStories: function() {
    $.ajax({
      url: '/api/stories',
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({stories: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('/api/stories', status, err.toString());
      }.bind(this)
    });
  },

  componentWillMount: function() {
    this.fetchTimer = null;
  },

  componentDidMount: function() {
    this.fetchStories();

    // refresh every minute
    this.fetchTimer = setInterval(this.fetchStories, 1000 * 60);
  },

  componentWillUnmount: function() {
    clearInterval(this.fetchTimer);
  },

  render: function() {

    var _this = this;

    var stories = this.state.stories.map(function(story, id) {
      return(
        <RssItem
          key={id}
          data={story}
          onMarkRead={_this.handleMarkRead}
        />);
    });

    var readerBody;

    if (this.state.stories.length === 0) {
      readerBody = <h3>There is nothing new under the sun</h3>;
    } else {
      readerBody = <div className="rss-stories">{stories}</div>;
    }

    return <div>
      <h1>
        <a
          className="rss-refresh"
          href="#"
          onClick={this.handleRefresh}
          title="Click to refresh"
        >Latest News</a>
      </h1>
      {readerBody}
    </div>;
  }
});
