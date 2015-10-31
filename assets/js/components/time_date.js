var TimeDate = React.createClass({
  render: function() {
    return <div className="time-date">
      <Calendar />
      <Clock />
      <Clock utc={true} />
    </div>;
  }
});
