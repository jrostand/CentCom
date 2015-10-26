calendar = new Calendar(
  container: '.calendar'
  lang: 'fr'
)

localClock = new Clock(
  svgBox: '.local-clock'
  diameter: 150
  borderColor: '#a1b56c'
  handColor:
    hours: '#ab4642'
    minutes: '#f7ca88'
)

localDigi = new DigitalClock(
  container: '.local-time'
)

utcClock = new Clock(
  svgBox: '.utc-clock'
  diameter: 150
  utc: true
)

utcDigi = new DigitalClock(
  container: '.utc-time'
  utc: true
)

weather = new Weather()

updateClocks = ->
  calendar.update()
  localClock.update()
  localDigi.update()
  utcClock.update()
  utcDigi.update()

$ ->
  $('.admin-bar .right-links').hide() if document.location.pathname is '/'

  setInterval weather.update, 1000 * 60 * 5

  setInterval updateClocks, 5000
