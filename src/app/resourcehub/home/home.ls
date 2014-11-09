angular.module 'ohmyhub.resourcehub.home', <[
  ohmyhub.common
  ui.router
]>

.factory 'Resources', ($http) ->
  do
    get: -> $http.get '/assests/resources-list.json'

.config ($stateProvider) ->
  $stateProvider
    .state 'resourcehub_home', do
      title: 'Resource Hub - Home'
      url: '/resourcehub/home'
      hub: do
        name: 'Resource Hub'
        root: '/resourcehub'
      controller: 'ResourceHubHomeCtrl'
      templateUrl: 'app/resourcehub/home/home.html'

.controller 'ResourceHubHomeCtrl', ($scope, HubMenu, Resources, FiltersStore) ->
  $scope.filters = FiltersStore.get!
  $scope.projects = []
  $scope.alerts = null

  Resources.get!
    .success -> 
      $scope.resources = it
      [menu, counts, status] = HubMenu.create $scope.resources, <[type license]>
      $scope.$parent.menu = menu
      $scope.$parent.counts = counts
      $scope.$parent.toggle = status.toggle
    .error -> 
      $scope.alerts = it
