var WeatherIcon = require('./weather_icon.jsx');

var ForecastRow = React.createClass({
  render: function() {
    return <div className="forecast-row">
      <span className="day">{this.props.data.label}</span>
      <WeatherIcon
        icon={this.props.data.icon}
        summary={this.props.data.summary}
      />
      <span className="max-temp">{this.props.data.max}</span>
      <span className="min-temp">{this.props.data.min}</span>
    </div>;
  }
});

module.exports = ForecastRow;
