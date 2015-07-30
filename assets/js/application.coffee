#= require_tree .

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

updateClocks = ->
  calendar.update()
  localClock.update()
  localDigi.update()
  utcClock.update()
  utcDigi.update()

onStoryOpen = ->
  data = $(@).data()
  title = $(@).parent().find ".title.active[data-story-id=#{data.storyId}]"

  $.ajax
    type: 'POST'
    url: "/api/stories/#{data.storyId}/edit"
    data: story: read: true
    success: ->
      title
        .animate({ color: '#a1b56c' }, 200)
        .animate({ color: '#f8f8f8' }, 200)
    error: ->
      title
        .animate({ color: '#ab4642' }, 200)
        .animate({ color: '#f8f8f8' }, 200)

$ ->
  $('.ui.accordion.stories').accordion onOpen: onStoryOpen

  $('.admin-bar .right-links').hide() if document.location.pathname is '/'

  setInterval updateClocks, 5000
