window.Utils = class Utils
  @zerofill: (num, length = 2) ->
    pad = Array(length).fill('0').join()
    (pad + num).slice length * -1
