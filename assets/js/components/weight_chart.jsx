var LineChart = require('./line_chart.jsx');

var WeightChart = React.createClass({
  getInitialState: function() {
    return {
      chart: {
        data: {},
        options: {}
      }
    };
  },

  componentWillMount: function() {
    this.updateTimer = null;
  },

  componentDidMount: function() {
    this.fetchData();

    // refresh hourly
    this.updateTimer = setInterval(this.fetchData, 1000 * 60 * 60);
  },

  componentWillUnmount: function() {
    clearInterval(this.updateTimer);
  },

  chartOptions: function() {
    return {
      animation: false,
      datasetFill: false
    }
  },

  fetchData: function() {
    $.ajax({
      url: '/api/weighings',
      dataType: 'json',
      success: function(data) {
        this.setState({
          chart: {
            data: this.transformData(data),
            options: this.chartOptions()
          }
        });
      }.bind(this),
      error: function(_xhr, status, err) {
        console.error('/api/weighings', status, err.toString());
      }.bind(this)
    });
  },

  transformData: function(data) {
    var days = data.map(function(weighing) {
      return weighing.day_label;
    });

    var weights = data.map(function(weighing) {
      return weighing.weight;
    });

    var bodyFats = data.map(function(weighing) {
      return weighing.body_fat;
    });

    return {
      labels: days,
      datasets: [
        {
          label: 'Weight',
          pointColor: '#ab4642', // Base16 red
          strokeColor: '#ab4642',
          data: weights
        },
        {
          label: 'Body Fat',
          pointColor: '#86c1b9', // Base16 cyan
          strokeColor: '#86c1b9',
          data: bodyFats
        }
      ]
    };
  },

  render: function() {
    return <LineChart
      chartId='weight-chart'
      chartData={this.state.chart.data}
      chartOptions={this.state.chart.options}
    />;
  }
});

module.exports = WeightChart;
