module ForecastFormatter
  def json_forecast(fc)
    current = fc.currently

    {
      currentIcon: icon_classes(current.icon),
      currentTemp: current.temperature.round(1).to_s,
      currentPressure: current.pressure.round,
      currentWind: {
        speed: current.windSpeed,
        direction: current.windBearing
      },
      forecast: forecast_days(fc.daily.data)
    }
  end

  private

  def forecast_days(days)
    days.first(5).map do |day|
      {
        label: Time.at(day.time).strftime('%a').downcase,
        icon: icon_classes(day.icon),
        min: day.temperatureMin.round(1).to_s,
        max: day.temperatureMax.round(1).to_s
      }
    end
  end

  def icon_classes(icon)
    case icon
      when 'clear-day' then %w(icon-sun)
      when 'clear-night' then %w(icon-moon)
      when 'cloudy' then %w(icon-cloud)
      when 'fog' then %w(icon-basecloud icon-mist)
      when 'hail' then %w(icon-hail)
      when 'partly-cloudy-day' then %w(icon-cloud icon-sunny)
      when 'partly-cloudy-night' then %w(icon-cloud icon-night)
      when 'rain' then %w(icon-basecloud icon-showers)
      when 'sleet' then %w(icon-basecloud icon-sleet)
      when 'snow' then %w(icon-basecloud icon-snow)
      when 'thunderstorm' then %w(icon-basecloud icon-thunder)
      when 'wind' then %w(icon-basecloud icon-sunny icon-windy)
      else %w(fa fa-alert)
    end
  end
end
