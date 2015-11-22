module ForecastFormatter
  def json_forecast(fc)
    current = fc.currently

    {
      currentIcon: current.icon,
      currentTemp: current.temperature.round(1).to_s,
      currentPressure: current.pressure.round,
      currentSummary: current.summary,
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
        icon: day.icon,
        min: day.temperatureMin.round(1).to_s,
        max: day.temperatureMax.round(1).to_s,
        summary: day.summary
      }
    end
  end
end
