angular.module 'ohmyhub.resourcehub.about', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'resourcehub_about', do
      title: 'Resource Hub - About'
      url: '/resourcehub/about'
      hub: do
        name: "Resource Hub"
      controller: \ResourcehubAboutCtrl
      templateUrl: \app/resourcehub/about/about.html

.controller \ResourcehubAboutCtrl, ($scope) ->
