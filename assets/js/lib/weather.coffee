window.Weather = class Weather
  constructor: (options) ->
    @options = $.extend(true, {
      container: '.weather'
    }, options)

    @init()

    @update()

  init: ->
    template = '<i class="current-conditions fa fa-question-circle"></i>'

    $(@options.container).append template

  update: ->
    @fetchWeather().then @setWeather, @setError

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

  setIcon: (conditions) ->
    icon = $('i.current-conditions')
    iconClasses = icon.attr('class').replace('current-conditions ', '')
    icon.removeClass iconClasses
    conditionsIcon = @translateIcon conditions.currently.icon
    icon.addClass "wi wi-#{conditionsIcon}"

  setWeather: (conditions) =>
    console.log 'COND', conditions
    @setIcon conditions

  setError: (err) =>
    $(@options.container).removeClass('weather-ok weather-error').addClass 'weather-error'

  translateIcon: (condition) ->
    switch condition
      when 'clear-day' then 'day-sunny'
      when 'clear-night' then 'night-clear'
      when 'partly-cloudy-day' then 'day-cloudy'
      when 'partly-cloudy-night' then 'night-cloudy'
      else condition
