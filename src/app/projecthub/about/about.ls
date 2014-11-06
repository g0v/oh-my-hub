angular.module 'OhMyHub.projecthub.about', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'project_about', do
      title: 'Project Hub - About'
      url: '/projecthub/about'
      controller: \AboutCtrl
      templateUrl: \app/projecthub/about/about.html

.controller \AboutCtrl, ($scope) ->
