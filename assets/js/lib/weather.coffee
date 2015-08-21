window.Weather = class Weather
  constructor: (options) ->
    @options = $.extend(true, {
      container: '.weather'
    }, options)

    @init()

    @update()

  init: ->
    template = '<div class="ui grid">
      <div class="row currently">
        <div class="five wide column icon">
          <ul class="forecast-icon"></ul>
        </div>
        <div class="four wide column numbers">
          <p class="temp"></p>
          <p class="qnh">QNH <span></span></p>
        </div>
        <div class="four wide column temps">
          <p class="high"></p>
          <p class="low"></p>
        </div>
        <div class="three wide column wind">
          <p class="direction"></p>
          <p>@</p>
          <p class="speed"></p>
        </div>
      </div>
      <div class="row forecast">
        <div class="four wide column day-1">
          <ul class="forecast-icon"></ul>
          <p class="temps">
            <span class="high"></span>/<span class="low"></span>
          </p>
        </div>
        <div class="four wide column day-2">
          <ul class="forecast-icon"></ul>
          <p class="temps">
            <span class="high"></span>/<span class="low"></span>
          </p>
        </div>
        <div class="four wide column day-3">
          <ul class="forecast-icon"></ul>
          <p class="temps">
            <span class="high"></span>/<span class="low"></span>
          </p>
        </div>
        <div class="four wide column day-4">
          <ul class="forecast-icon"></ul>
          <p class="temps">
            <span class="high"></span>/<span class="low"></span>
          </p>
        </div>
      </div>
    </div>'

    $(@options.container).append template

  update: ->
    _expiry = new Date(parseInt(Cache.get('forecast_expiry'))).getTime()

    if isNaN(_expiry) or Date.now() >= _expiry
      @fetchWeather().then @setWeather, @setError
    else
      @setWeather(JSON.parse(Cache.get('forecast')), false)

  buildIcon: (container, iconCode) ->
    container.remove 'li'
    for klass in @iconClasses(iconCode)
      container.append @iconPart klass

  fetchWeather: ->
    new Promise (resolve, reject) ->
      req = new XMLHttpRequest()
      req.open 'GET', '/api/weather'
      req.onerror = -> reject Error('Network error')
      req.onload = ->
        if req.status is 200
          resolve JSON.parse req.response
        else
          reject Error(req.statusText)
      req.send()

  iconClasses: (condition) ->
    switch condition
      when 'clear-day' then ['icon-sun']
      when 'clear-night' then ['icon-moon']
      when 'cloudy' then ['icon-cloud']
      when 'fog' then ['icon-basecloud', 'icon-mist']
      when 'hail' then ['icon-hail']
      when 'partly-cloudy-day' then ['icon-cloud', 'icon-sunny']
      when 'partly-cloudy-night' then ['icon-cloud', 'icon-night']
      when 'rain' then ['icon-basecloud', 'icon-showers']
      when 'sleet' then ['icon-basecloud', 'icon-sleet']
      when 'snow' then ['icon-basecloud', 'icon-snow']
      when 'thunderstorm' then ['icon-basecloud', 'icon-thunder']
      when 'wind' then ['icon-basecloud', 'icon-sunny', 'icon-windy']
      else ['fa', 'fa-alert']

  iconPart: (klass) -> "<li class='#{klass}'></li>"

  setConditionsIcon: ->
    @buildIcon $('.currently .icon ul'), @forecast.currently.icon

  setCurrentData: ->
    data = $('.currently .numbers')
    _now = @forecast.currently

    data.find('.qnh span').text Utils.zerofill(Math.round(_now.pressure), 4)
    data.find('.temp').text "#{Math.round _now.temperature} C"

  setError: (err) =>
    $(@options.container).removeClass('weather-ok weather-error').addClass 'weather-error'

  setForecast: ->
    forecastBox = $('.forecast')
    _conditions = @forecast.daily.data.slice 1, 5

    for day, idx in _conditions
      dayBox = forecastBox.find ".day-#{idx + 1}"
      @buildIcon dayBox.find('.forecast-icon'), day.icon
      dayBox.find('.high').text Math.ceil day.temperatureMax
      dayBox.find('.low').text Math.floor day.temperatureMin

  setTemps: ->
    currentBox = $('.currently .temps')
    highTemp = currentBox.find '.high'
    lowTemp = currentBox.find '.low'
    _today = @forecast.daily.data[0]

    highTemp.text "#{Math.ceil _today.temperatureMax} C"
    lowTemp.text "#{Math.floor _today.temperatureMin} C"

  setWind: ->
    gauge = $('.wind')
    speed = gauge.find '.speed'
    _now = @forecast.currently

    speed.removeClass 'low med high'
    speed.addClass @windClass _now.windSpeed

    gauge.find('.direction').text Utils.zerofill(_now.windBearing, 3)
    speed.text _now.windSpeed

  setWeather: (conditions, updateCache = true) =>
    @forecast = conditions
    @updateCache() if updateCache is true

    @setConditionsIcon()
    @setCurrentData()
    @setForecast()
    @setTemps()
    @setWind()

  updateCache: ->
    _newExpiry = new Date(Date.now() + (5 * 60 * 1000)).getTime()
    Cache.set 'forecast_expiry', _newExpiry
    Cache.set 'forecast', JSON.stringify(@forecast)

  windClass: (speed) ->
    speed = parseFloat speed
    switch
      when speed < 10.0 then 'low'
      when speed < 20.0 then 'med'
      else 'high'
