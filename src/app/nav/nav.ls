angular.module 'OhMyHub.nav', <[
  ui.router
]>

.factory 'NavFilters', ->
  filters = do
    attributes:  []
    search_text: null

  do
    get: -> filters
    add: (v) ->
      console.log "Added filter attribute: #{v}"
      unless v in filters.attributes
        filters.attributes.push v
      else
        throw "should not add a duplicated attribute into filters."
    del: (v) ->
      if filters.attributes.length > 0
        console.log "Removed filter attribute: #{v}"
        filters.attributes.splice (filters.attributes.indexOf v), 1
      else
        throw "should not remove a attribute from filters."

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

  $scope.toggleFilter = (v) ->
    if v in $scope.filters.attributes
      NavFilters.del v
    else
      NavFilters.add v
  $scope.goto = ->
    $location.path it
