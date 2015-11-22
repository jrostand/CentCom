require('normalize.css');
require('font-awesome');
require('weather-icons-base');
require('weather-icons-wind');
require('../css/application.scss');

var ReactDOM = require('react-dom'),
    RssReader = require('./components/rss_reader.jsx'),
    TimeDate = require('./components/time_date.jsx'),
    Weather = require('./components/weather.jsx');
// WeightChart = require('./components/weight_chart.jsx');

ReactDOM.render(
  <RssReader />,
  document.getElementById('rss-module')
);

ReactDOM.render(
  <Weather />,
  document.getElementById('weather-module')
);

ReactDOM.render(
  <TimeDate />,
  document.getElementById('timedate-module')
);

/*
ReactDOM.render(
  <WeightChart />,
  document.getElementById('weight-module')
);
*/
