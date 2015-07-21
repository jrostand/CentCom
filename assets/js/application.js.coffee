#= require_tree .

zerofill = (num) ->
  pad = '00'
  (pad + num).slice -pad.length

setClock = (which, time) ->
  parts = {}

  switch which
    when 'utc'
      parts =
        hours: zerofill time.getUTCHours()
        minutes: zerofill time.getUTCMinutes()
    when 'local'
      parts =
        hours: zerofill time.getHours()
        minutes: zerofill time.getMinutes()

  $(".#{which}-hour").text parts['hours']
  $(".#{which}-minute").text parts['minutes']

setDate = (time) ->
  parts =
    day: time.getDate()
    weekday: time.getDay()
    month: time.getMonth()

  months = [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]

  days = [
    'Sunday'
    'Monday'
    'Tuesday'
    'Wednesday'
    'Thursday'
    'Friday'
    'Saturday'
  ]

  $(".weekday").text days[parts['weekday']]
  $(".month").text months[parts['month']]
  $(".day").text parts['day']

clock = new Clock(
  svgBox: '.d3clock'
  diameter: 250
)

updateClocks = ->
  time = new Date()
  setClock 'local', time
  setClock 'utc', time
  setDate time
  clock.update()

$ ->
  $('.ui.accordion').accordion()

  updateClocks()

  setInterval updateClocks, 5000
