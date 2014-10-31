angular.module 'OhMyHub.about', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'about', do
      title: 'about'
      url: '/about'
      controller: \AboutCtrl
      templateUrl: \app/about/about.html

.controller \AboutCtrl, ($scope) ->
