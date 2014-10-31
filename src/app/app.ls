angular.module \OhMyHub, <[
  OhMyHub.project
  OhMyHub.wiki
  OhMyHub.about
  OhMyHub.nav
	ui.router
]>

.config ($stateProvider, $urlRouterProvider) ->
  $(".ui.dropdown").dropdown();
  $(".ui.accordion").accordion();
  $urlRouterProvider.otherwise \/project
.controller \AppCtrl, ($scope, $location) ->

.run ['$rootScope', '$state', '$stateParams', ($rootScope,   $state,   $stateParams) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
]