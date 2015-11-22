var Chart = require('chart.js');

var LineChart = React.createClass({
  componentDidMount: function() {
    var context = document.getElementById(this.props.chartId).getContext('2d');

    this.chart = new Chart(context).Line(this.props.chartData, this.props.chartOptions);
  },

  componentDidUpdate: function() {
    this.chart.update();
  },

  render: function() {
    return <div className="chart line-chart">
      <canvas id={this.props.chartId} width="400" height="200"></canvas>
    </div>;
  }
});

module.exports = LineChart;
