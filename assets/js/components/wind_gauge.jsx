var WindGauge = React.createClass({
  getDefaultProps: function() {
    return {
      wind: {}
    }
  },

  iconClass: function() {
    return 'wi wi-wind from-' + this.props.wind.direction + '-deg';
  },

  render: function() {
    return <div className="wind-gauge weather-box">
      <p><i className={this.iconClass()}></i></p>
      <p className="wind-speed">{this.props.wind.speed} m/s</p>
    </div>;
  }
});

module.exports = WindGauge;
