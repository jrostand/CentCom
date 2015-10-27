var WeatherIcon = React.createClass({
  getDefaultProps: function() {
    return {
      icon: ['icon-sun']
    };
  },

  iconParts: function() {
    var parts = this.props.icon.map(function(klass) {
      return <li key={klass} className={klass}></li>;
    });

    return parts;
  },

  render: function() {
    return <div className="current-icon weather-box">
      <ul className="forecast-icon">
        {this.iconParts()}
      </ul>
    </div>;
  }
});
