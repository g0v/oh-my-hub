angular.module 'OhMyHub.nav', <[
  ui.router
]>

.factory 'NavFilters', ->
  filters = do
    attributes:  []
    search_text: null

  do
    get: -> filters

.controller \NavCtrl, ($scope, $location, NavFilters) ->
  $scope.filters = NavFilters.get!
  $scope.menu_items = [
    * name: 'category'
      toggle: true
      sub_items: [
        * name: "開放資料"
          count: 24
      ]
    * name: 'tools'
      sub_items: [
        * name: "開放資料"
          count: 24
      ]      
  ]

  $scope.toggle = {
    "switcher": true
    "category" : false
    "tools" : false
  }

  $scope.goto = ->
    $location.path it
