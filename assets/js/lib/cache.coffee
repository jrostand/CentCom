window.Cache = class Cache
  _backend = window.localStorage

  @get: (key) -> _backend.getItem key

  @getMulti: (keys = []) ->
    _out = {}
    _out[key] = Cache.get(key) for key in keys
    _out

  @set: (key, value) -> _backend.setItem key, value

  @setMulti: (obj = {}) ->
    Cache.set(key, val) for own key, val of obj
