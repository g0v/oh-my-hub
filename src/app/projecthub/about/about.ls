angular.module 'ohmyhub.projecthub.about', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'project_about', do
      title: 'Project Hub - About'
      url: '/projecthub/about'
      hub: do
        name: "Project Hub"
        root: "/projecthub"
      controller: \ProjecthubAboutCtrl
      templateUrl: \app/projecthub/about/about.html

.controller \ProjecthubAboutCtrl, ($scope) ->
