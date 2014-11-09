angular.module 'ohmyhub.resourcehub.wiki', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'resource_wiki', do
      title: 'Resource Hub - Wiki'
      url: '/resourcehub/wiki'
      hub: do      
        name: "Resource Hub"
        root: "/resourcehub"
      controller: \ResourcehubWikiCtrl
      templateUrl: \app/resourcehub/wiki/wiki.html

.controller \ResourcehubWikiCtrl, ($scope) ->