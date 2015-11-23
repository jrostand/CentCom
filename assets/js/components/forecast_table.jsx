var ForecastRow = require('./forecast_row.jsx');

var ForecastTable = React.createClass({
  getDefaultProps: function() {
    return { days: [] };
  },

  render: function() {
    var forecastRows = this.props.days.map(function(day, id) {
      return <ForecastRow data={day} key={id} />
    });

    return <div className="forecast-table">
      {forecastRows}
    </div>;
  }
});

module.exports = ForecastTable;
