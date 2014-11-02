angular.module 'OhMyHub.nav', <[
  ui.router
]>

.factory 'NavFilters', ->
  filters = do
    attributes:  []
    search_text: null

  do
    get: -> filters

.factory 'NavMenu', ->
  menu = {}
  counts = {}
  do
    create: (projects) ->
      for project in projects
        for attrname in <[category tag tool license]>
          attrval = project[attrname] 
          unless menu[attrname]?
            menu[attrname] = {}
          for val in attrval
            unless menu[attrname][val]?
              menu[attrname][val] = 1
            else
              menu[attrname][val] += 1
            counts[attrname] = Object.keys menu[attrname] .length
      return [menu, counts]

.controller \NavCtrl, ($scope, $location, NavMenu, NavFilters, Projects) ->
  $scope.filters = NavFilters.get!
  projects <- Projects.get!
  [menu, counts] = NavMenu.create projects
  $scope.counts = counts
  $scope.menu = menu

  $scope.toggle = {
    "switcher": true
    "category" : false
    "tools" : false
  }

  $scope.goto = ->
    $location.path it
