get '/api/weather' do
  forecast = ForecastIO.forecast(
    CentCom::Settings.forecast_lat,
    CentCom::Settings.forecast_long,
    params: {
      exclude: 'minutely,flags',
      units: 'si'
    }
  )

  render_json forecast
end
