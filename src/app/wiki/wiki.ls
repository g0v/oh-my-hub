angular.module 'OhMyHub.wiki', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'wiki', do
      title: 'wiki'
      url: '/wiki'
      controller: \WikiCtrl
      templateUrl: \app/wiki/wiki.html

.controller \WikiCtrl, ($scope) ->