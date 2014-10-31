angular.module 'OhMyHub.nav', <[
  ui.router
]>

.controller \NavCtrl, ($scope, $location) ->
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
