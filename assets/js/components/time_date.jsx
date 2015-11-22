var Calendar = require('./calendar.jsx'),
    Clock = require('./clock.jsx');

var TimeDate = React.createClass({
  render: function() {
    return <div className="time-date">
      <Calendar />
      <Clock />
      <Clock utc={true} />
    </div>;
  }
});

module.exports = TimeDate;
