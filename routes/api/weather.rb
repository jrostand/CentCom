include ForecastFormatter

get '/api/weather' do
  forecast = ForecastIO.forecast(
    CentCom::Settings.forecast_lat,
    CentCom::Settings.forecast_long,
    params: {
      exclude: 'hourly,minutely,flags',
      units: 'si'
    }
  )

  render_json json_forecast(forecast)
end
