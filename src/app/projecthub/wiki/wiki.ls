angular.module 'ohmyhub.projecthub.wiki', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'projecthub_wiki', do
      title: 'Project Hub - Wiki'
      url: '/projecthub/wiki'
      hub: do      
        name: "Project Hub"
        root: '/projecthub'
      controller: \ProjecthubWikiCtrl
      templateUrl: \app/projecthub/wiki/wiki.html

.controller \ProjecthubWikiCtrl, ($scope) ->