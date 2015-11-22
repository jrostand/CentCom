var WeatherIcon = React.createClass({
  getDefaultProps: function() {
    return {
      icon: 'clear-day'
    };
  },

  iconClass: function() {
    return "wi wi-forecast-io-" + this.props.icon;
  },

  render: function() {
    return <div className="current-icon weather-box">
      <i className={this.iconClass()} title={this.props.summary}></i>
    </div>;
  }
});

module.exports = WeatherIcon;
