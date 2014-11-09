angular.module \OhMyHub.projecthub, <[
  OhMyHub.projecthub.project
  OhMyHub.projecthub.wiki
  OhMyHub.projecthub.about
	ui.router
]>

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise \/projecthub/project
