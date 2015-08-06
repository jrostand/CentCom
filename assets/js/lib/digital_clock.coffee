window.DigitalClock = class Clock
  constructor: (options) ->
    @options = $.extend(true, {
      container: '.digital-clock'
      showSeconds: false
      twentyFour: true
      utc: false
    }, options)

    @init()

    @update()

  init: ->
    clockTemplate = '<span class="hours">00</span>:<span class="minutes">00</span>'

    clockTemplate += ':<span class="seconds">00</span>' if @options.showSeconds

    clockTemplate += ' <span class="ampm">AM</span>' unless @options.twentyFour

    $(@options.container).append clockTemplate

  update: ->
    parts = @getTime()

    $("#{@options.container} .hours").text Utils.zerofill parts.hours
    $("#{@options.container} .minutes").text Utils.zerofill parts.minutes
    $("#{@options.container} .seconds").text(Utils.zerofill parts.seconds) if @options.showSeconds
    $("#{@options.container} .ampm").text(parts['ampm'])unless @options.twentyFour

  getTime: ->
    time = new Date()

    parts = if @options.utc
      hours: time.getUTCHours()
      minutes: time.getUTCMinutes()
      seconds: time.getUTCSeconds()
    else
      hours: time.getHours()
      minutes: time.getMinutes()
      seconds: time.getSeconds()

    parts['ampm'] = if parts.hours < 12 then 'am' else 'pm'

    if !@options.twentyFour
      if parts.hours is 0
        parts.hours = 12
      else
        parts.hours = (parts.hours % 12)

    return parts
