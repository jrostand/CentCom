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

weather = new Weather()

updateClocks = ->
  calendar.update()
  localClock.update()
  localDigi.update()
  utcClock.update()
  utcDigi.update()

rssRefresh = (event) ->
  event.preventDefault()

  heading = $('.rss-reader h1 a')

  $.ajax
    type: 'POST'
    url: '/api/feeds/refresh'
    success: ->
      heading
        .animate({ color: '#a1b56c' }, 200)
        .animate({ color: '#f8f8f8' }, 200)
    error: ->
      heading
        .animate({ color: '#ab4642' }, 200)
        .animate({ color: '#f8f8f8' }, 200)

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

  $('.rss-refresh').bind 'click', rssRefresh

  $('.admin-bar .right-links').hide() if document.location.pathname is '/'

  setInterval updateClocks, 5000
