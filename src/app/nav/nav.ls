angular.module 'OhMyHub.nav', <[
  ui.router
]>

.factory 'NavFilters', ->
  filters = do
    attributes:  {}
    search_text: null
    indicators: []

  do
    get: -> filters
    add: (c, v) ->
      console.log "Added filter attribute: #{v}"
      unless filters.attributes[c]?
        filters.attributes[c] = []
      unless v in filters.attributes[c]
        filters.attributes[c].push v
        filters.indicators.push name: v, category: c
      else
        throw "should not add a duplicated attribute into filters."
    del: (c, v) ->
      if filters.attributes[c]? and filters.attributes[c].length > 0
        console.log "Removed filter attribute: #{v}"
        filters.attributes[c].splice (filters.attributes[c].indexOf v), 1
        filters.indicators.splice (filters.indicators.indexOf {name:v, category:c}), 1
        if filters.attributes[c].length == 0
          delete filters.attributes[c]
          filters.indicators = []
      else
        throw "should not remove a attribute from empty filters."

.factory 'NavMenu', ->
  menu = {}
  counts = {}
  toggle = do
    switcher: true
  do
    create: (projects) ->
      for project in projects
        for attrname in <[category type tag tool license]>
          toggle[attrname] = false
          attrval = project[attrname] or []
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
      return [menu, counts, toggle]

.controller \NavCtrl, ($scope, $location, NavMenu, NavFilters, Projects) ->
  $scope.filters = NavFilters.get!
  projects <- Projects.get!
  [menu, counts, toggle] = NavMenu.create projects
  $scope.counts = counts
  $scope.menu = menu
  $scope.toggle = toggle

  $scope.goto = ->
    $location.path it
  $scope.toggleFilter = (c, v) ->
    if $location.path != '/project'
      $scope.goto '/project'
    if $scope.filters.attributes[c]? and v in $scope.filters.attributes[c]
      NavFilters.del c, v
    else
      NavFilters.add c, v
