var WeatherIcon = React.createClass({
  iconClass: function() {
    return 'wi wi-forecast-io-' + this.props.icon;
  },

  render: function() {
    return <div className="current-icon weather-box">
      <i className={this.iconClass()} title={this.props.summary}></i>
    </div>;
  }
});

module.exports = WeatherIcon;
