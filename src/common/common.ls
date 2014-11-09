angular.module 'ohmyhub.common', []

.filter 'containsAnyAattr', -> 
  (items, conds) -> 
    if items.length > 0 and conds
        _ = require 'prelude-ls'
        contains-any-attr = ->
          _.and-list [it[k] and (_.intersection v, it[k]) .length > 0 or false for k,v of conds]
        return items |> _.filter contains-any-attr
    else      
      return []

.factory 'FiltersStore', ->
  _ = require 'prelude-ls'
  filters = do
    attributes:  {}
    indicators: []

  do
    clear: -> 
      filters := do
        attributes: {}
        indicators: []
    get: -> filters
    add: (c, v) ->
      throw new Erro "try to add undifined condition into filters." unless c? and v?
      console.log "Added filter attribute: #{v}"
      unless filters.attributes[c]?
        filters.attributes[c] = []
      unless v in filters.attributes[c]
        filters.attributes[c].push v
        filters.indicators.push name: v, category: c
      else
        throw new Error "should not add a duplicated attribute into filters."
    del: (c, v) ->
      throw new Error "try to remove undifined condition from filters." unless c? and v?
      if filters.attributes[c]? and filters.attributes[c].length > 0
        console.log "Removed filter attribute: #{v}"
        filters.attributes[c] = _.reject (-> angular.equals it, v), filters.attributes[c]
        filters.indicators = _.reject (-> angular.equals it, {name:v, category:c}), filters.indicators
        if filters.attributes[c].length == 0
          delete filters.attributes[c]
      else
        throw new Error "should not remove a attribute from empty filters."

.factory 'ActivedHubsStatus', ->
  _default = null
  hubs = {}
  do
    get: -> do
      default: _default
      hubs: hubs
    add: (codename, info) -> 
      hubs[codename] = info
    default: (codename) ->
      if hubs[codename]?
        _default := hubs[codename]
      else
        throw "unactived hub: #{codename}"

.factory 'HubMenu', ->
  do
    create: (items, attributes) ->
      menu = {}
      counts = {}
      status = do
        toggle: do
          switch: false      
      for item in items
        for attrname in attributes
          status.toggle[attrname] = false
          attrval = item[attrname] or []
          unless menu[attrname]?
            menu[attrname] = {}
            counts[attrname] = 0
          for val in attrval
            unless menu[attrname][val]?
              menu[attrname][val] = 1
            else
              menu[attrname][val] += 1
            if menu[attrname]
              counts[attrname] = Object.keys menu[attrname] .length
      return [menu, counts, status]