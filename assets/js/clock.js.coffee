class Clock
  constructor: (options) ->
    @options = $.extend(true, {
      svgBox: '.clock'
      fillColor: '#181818'
      borderColor: '#ab4642'
      handColor:
        minutes: '#ba8baf'
        hours: '#7cafc2'
      diameter: 200
      borderWidth: 4
      drawTicks: true
      ticks:
        height: 10
        width: 2
      utc: false
      twentyfour: false
    }, options)

    @initSvg()

    @drawFace()

    @drawTicks() if @options.drawTicks is true

    @update()

  drawFace: ->
    @face = @svgBox.append('svg:g')
      .attr('transform', "translate(#{@options.diameter / 2}, #{@options.diameter / 2})")

    @face.append('svg:circle')
      .attr('r', (@options.diameter / 2) - @options.borderWidth)
      .attr('fill', @options.fillColor)
      .attr('stroke', @options.borderColor)
      .attr('stroke-width', @options.borderWidth)

  drawTicks: ->
    @ticks = @svgBox.append('svg:g')
      .attr('transform', "translate(#{@options.diameter / 2}, #{@options.diameter / 2})")

    @ticks.selectAll('.clock-tick')
      .data(d3.range(if @options.twentyfour then 24 else 12))
      .enter()
      .append('svg:rect')
      .attr('class', 'clock-tick')
      .attr('x', -(0.5 * @options.ticks.width))
      .attr('y', -(@options.diameter / 2) + (0.08 * @options.diameter))
      .attr('width', 2)
      .attr('height', (_, i) =>
        if i % (if @options.twentyfour then 4 else 3) is 0
          (@options.ticks.height)
        else
          (@options.ticks.height / 2)
      )
      .attr('transform', (_, i) => "rotate(#{i * (if @options.twentyfour then 15 else 30)})")
      .attr('fill', @options.borderColor)

  initSvg: ->
    @svgBox = d3.select(@options.svgBox)
      .append('svg:svg')
      .attr('width', @options.diameter)
      .attr('height', @options.diameter)

  setTimeFields: ->
    now = new Date()
    data = [
      {
        'unit': 'minutes'
        'value': if @options.utc then now.getUTCMinutes() else now.getMinutes()
      }
      {
        'unit': 'hours'
        'value': if @options.utc then now.getUTCHours() else now.getHours()
      }
    ]

  update: ->
    data = @setTimeFields()

    @face.selectAll('.clock-hand').remove()

    scaleMinutes = d3.scale.linear().domain([0, 59 + 59/60]).range([0, 2 * Math.PI])

    scaleHours =
      if @options.twentyfour
        d3.scale.linear().domain([0, 23 + 59/60]).range([0, 2 * Math.PI])
      else
        d3.scale.linear().domain([0, 11 + 59/60]).range([0, 2 * Math.PI])

    minuteArc = d3.svg.arc()
      .innerRadius(0)
      .outerRadius((1 / 3) * @options.diameter)
      .startAngle((d) -> scaleMinutes(d.value))
      .endAngle((d) -> scaleMinutes(d.value))

    hourArc = d3.svg.arc()
      .innerRadius(0)
      .outerRadius(0.2 * @options.diameter)
      .startAngle((d) => scaleHours(d.value % (if @options.twentyfour then 24 else 12)))
      .endAngle((d) => scaleHours(d.value % (if @options.twentyfour then 24 else 12)))

    @face.selectAll('.clock-hand')
      .data(data)
      .enter()
      .append('svg:path')
      .attr('d', (d) ->
        if d.unit is 'minutes'
          minuteArc d
        else if d.unit is 'hours'
          hourArc d
      )
      .attr('class', 'clock-hand')
      .attr('stroke', (d) => @options.handColor[d.unit])
      .attr('stroke-width', 2)
      .attr('fill', 'none')

window.Clock = Clock
