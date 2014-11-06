angular.module 'OhMyHub.projecthub.wiki', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'project_wiki', do
      title: 'Project Hub - Wiki'
      url: '/projecthub/wiki'
      controller: \WikiCtrl
      templateUrl: \app/projecthub/wiki/wiki.html

.controller \WikiCtrl, ($scope) ->