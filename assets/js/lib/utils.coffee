window.Utils = class Utils
  @zerofill: (num) ->
    pad = '00'
    (pad + num).slice -2
