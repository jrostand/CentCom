var CurrentTemp = require('./current_temp.jsx'),
    ForecastTable = require('./forecast_table.jsx'),
    WeatherIcon = require('./weather_icon.jsx'),
    WindGauge = require('./wind_gauge.jsx');

var Weather = React.createClass({
  getInitialState: function() {
    return { forecast: {} };
  },

  componentWillMount: function() {
    this.fetchTimer = null;
  },

  componentDidMount: function() {
    this.fetchWeather();

    // refresh every minute
    this.fetchTimer = setInterval(this.fetchWeather, 1000 * 60);
  },

  componentWillUnmount: function() {
    clearInterval(this.fetchTimer);
  },

  fetchWeather: function() {
    if (this.hasCurrentForecast()) {
      this.setState({ forecast: JSON.parse(localStorage.forecast) });
    } else {

      $.ajax({
        url: '/api/weather',
        dataType: 'json',
        cache: true,
        success: function(data) {
          this.setState({ forecast: data });
          this.updateStoredForecast(data);
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('/api/stories', status, err.toString());
        }.bind(this)
      });
    }
  },

  hasCurrentForecast: function() {
    var expiration = parseInt(localStorage.forecast_expiry);

    if (isNaN(expiration) || Date.now() >= expiration) {
      return false;
    } else {
      return true;
    }
  },

  updateStoredForecast: function(forecast) {
    // set a 'stale' time of 5 minutes
    var nextExpiration = new Date(Date.now() + (5 * 60 * 1000)).getTime();

    localStorage.forecast = JSON.stringify(forecast);
    localStorage.forecast_expiry = nextExpiration;
  },

  render: function() {
    var forecast = this.state.forecast;

    return <div className="weather">
      <div className="current-conditions">
        <WeatherIcon
          icon={forecast.currentIcon}
          summary={forecast.currentSummary}
        />
        <CurrentTemp temp={forecast.currentTemp} />
        <WindGauge wind={forecast.currentWind} />
      </div>

      <ForecastTable days={forecast.forecast} />
    </div>;
  }
});

module.exports = Weather;
