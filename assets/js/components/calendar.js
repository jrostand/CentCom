var Calendar = React.createClass({
  getInitialState: function() {
    return {
      date: '',
      weekday: ''
    };
  },

  componentWillMount: function() {
    this.updateTimer = null;
  },

  componentDidMount: function() {
    this.setDate();

    // refresh every 30 seconds
    this.updateTimer = setInterval(this.setDate, 1000 * 30);
  },

  componentWillUnmount: function() {
    clearInterval(this.updateTimer);
  },

  setDate: function() {
    var date = new Date();

    var lang = this.props.lang || 'fr';

    var dateOptions = {
      day: 'numeric',
      month: 'long'
    };

    var weekdayOptions = {
      weekday: 'long'
    };

    this.setState({
      date: date.toLocaleDateString(lang, dateOptions),
      weekday: date.toLocaleDateString(lang, weekdayOptions)
    });
  },

  render: function() {
    return <p className="calendar">
      <span className="weekday">{this.state.weekday}</span>
      <span>&nbsp;</span>
      <span className="date">{this.state.date}</span>
    </p>;
  }
});
