var Clock = React.createClass({
  getInitialState: function() {
    return { currentTime: '' };
  },

  componentWillMount: function() {
    this.clockTimer = null;

    var tzClass;

    if (this.props.utc === true) {
      tzClass = 'utc';
    } else {
      tzClass = 'local';
    }

    this.setState({ tzClass: 'clock ' + tzClass });
  },

  componentDidMount: function() {
    this.setTime();

    // refresh every 5 seconds
    this.clockTimer = setInterval(this.setTime, 1000 * 5);
  },

  componentWillUnmount: function() {
    clearInterval(this.clockTimer);
  },

  setTime: function() {
    var date = new Date();

    var lang = this.props.lang || 'fr';

    var timeOptions = {
      hour: 'numeric',
      minute: 'numeric'
    };

    if (this.props.utc === true) {
      timeOptions['timeZone'] = 'UTC';
    }

    this.setState({ currentTime: date.toLocaleTimeString(lang, timeOptions) });
  },

  render: function() {
    return <div className={this.state.tzClass}>
      <p>{this.state.currentTime}</p>
    </div>;
  }
});
