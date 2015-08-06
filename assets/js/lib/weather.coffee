window.Weather = class Weather
  constructor: (options) ->
    @options = $.extend(true, {
      container: '.weather'
    }, options)

    @init()

    @update()

  init: ->
    template = '<div class="ui grid">
      <div class="five wide column">
        <i class="current-conditions"></i>
      </div>
      <div class="three wide column sunrise">
        <i class="icon-sunrise"></i>
        <p class="time"></p>
      </div>
      <div class="three wide column sunset">
        <i class="icon-sunset"></i>
        <p class="time"></p>
      </div>
      <div class="five wide column"></div>
    </div>'

    $(@options.container).append template

  update: ->
    _expiry = new Date(parseInt(Cache.get('forecast_expiry'))).getTime()

    if Date.now() >= _expiry
      @fetchWeather().then @setWeather, @setError
    else
      @setWeather(JSON.parse(Cache.get('forecast')), false)

  fetchWeather: ->
    new Promise (resolve, reject) ->
      req = new XMLHttpRequest()
      req.open 'GET', '/api/weather'

      req.onload = ->
        if req.status is 200
          resolve JSON.parse req.response
        else
          reject Error(req.statusText)

      req.onerror = -> reject Error('Network error')

      req.send()

  setConditionsIcon: ->
    icon = $('i.current-conditions')
    icon.removeClass()
    icon.addClass "current-conditions #{@translateIcon @forecast.currently.icon}"

  setSunriseSunset: ->
    sunrise = $('.sunrise .time')
    sunset = $('.sunset .time')
    _today = @forecast.daily.data[0]

    sunriseTime = new Date(_today.sunriseTime * 1000)
    sunsetTime = new Date(_today.sunsetTime * 1000)

    sunrise.text "#{Utils.zerofill sunriseTime.getHours()}:#{Utils.zerofill sunriseTime.getMinutes()}"
    sunset.text "#{Utils.zerofill sunsetTime.getHours()}:#{Utils.zerofill sunsetTime.getMinutes()}"

  setWeather: (conditions, updateCache = true) =>
    @forecast = conditions
    @updateCache() if updateCache is true

    @setConditionsIcon()
    @setSunriseSunset()

  setError: (err) =>
    $(@options.container).removeClass('weather-ok weather-error').addClass 'weather-error'

  translateIcon: (condition) ->
    switch condition
      when 'clear-day' then 'icon-sun'
      when 'clear-night' then 'icon-moon'
      when 'cloudy' then 'icon-cloud'
      when 'fog' then 'icon-basecloud icon-mist'
      when 'hail' then 'icon-hail'
      when 'partly-cloudy-day' then 'icon-cloud icon-sunny'
      when 'partly-cloudy-night' then 'icon-cloud icon-night'
      when 'rain' then 'icon-basecloud icon-showers'
      when 'sleet' then 'icon-basecloud icon-sleet'
      when 'snow' then 'icon-basecloud icon-snow'
      when 'thunderstorm' then 'icon-basecloud icon-thunder'
      else 'fa fa-alert'

  updateCache: ->
    _newExpiry = new Date(Date.now() + (5 * 60 * 1000)).getTime()
    Cache.set 'forecast_expiry', _newExpiry
    Cache.set 'forecast', JSON.stringify(@forecast)
