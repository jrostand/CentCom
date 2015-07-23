window.Calendar = class Calendar
  constructor: (options) ->
    @options = $.extend(true, {
      container: '.calendar'
      lang: 'en'
    }, options)

    @init()

    @update()

  init: ->
    calendarTemplate = '<span class="weekday">Weekday</span>
    <span class="day">00</span>
    <span class="month">Month</span>'

    $(@options.container).append calendarTemplate

  update: ->
    date = new Date()

    $("#{@options.container} .weekday").text @dayWord(date.getDay())
    $("#{@options.container} .day").text date.getDate()
    $("#{@options.container} .month").text @monthWord(date.getMonth())

  dayWord: (index) -> dayWords[@options.lang][index]

  monthWord: (index) -> monthWords[@options.lang][index]

  dayWords =
    en: [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]
    fr: [
      'dimanche'
      'lundi'
      'mardi'
      'mercredi'
      'jeudi'
      'vendredi'
      'samedi'
    ]

  monthWords =
    en: [
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
    fr: [
      'janvier'
      'février'
      'mars'
      'avril'
      'mai'
      'juin'
      'juillet'
      'août'
      'septembre'
      'octobre'
      'novembre'
      'décembre'
    ]
