var CurrentTemp = React.createClass({
  getDefaultProps: function() {
    return { temp: 12.3 };
  },

  render: function() {
    return <div className="current-temp weather-box">
      <p>{this.props.temp}&deg;</p>
    </div>
  }
});

module.exports = CurrentTemp;
