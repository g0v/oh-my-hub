angular.module \OhMyHub, <[
  OhMyHub.projecthub
  OhMyHub.nav
	ui.router
]>

.config ($stateProvider, $urlRouterProvider) ->
  $(".ui.dropdown").dropdown();
  $(".ui.accordion").accordion();
  $urlRouterProvider.otherwise \/projecthub/project
.controller \AppCtrl, ($scope, $location) ->

.run ['$rootScope', '$state', '$stateParams', ($rootScope,   $state,   $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
]