angular.module 'OhMyHub.nav', <[
  ui.router
]>

.factory 'Nav', ->
  filters = do
    attributes:  [
        * name: '電子商務'
        * name: '種子階段'
        * name: '獨資'
    ]
    search_text: null

  do
    get_filters: -> filters

.controller \NavCtrl, ($scope, $location, Nav) ->
  $scope.filters = Nav.get_filters!
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
