try 
  templates = angular.module 'templates'
  console.log "using template cach."
catch
  console.log "using html."

deps = <[
  ohmyhub.common
  ohmyhub.resourcehub  
  ohmyhub.projecthub  
  ohmyhub.nav
  ui.router
  firebase
]>

angular.module 'ohmyhub', deps

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/resourcehub/home'	

.controller \AppCtrl, ($scope, $state, $location, FiltersStore) ->
  $scope.delFilter = FiltersStore.del  
  $scope.switchHub = (huburl) ->
    FiltersStore.clear! 
    $location.path huburl
  $scope.goto = (path) ->	
    $location.path "#{$state.current.hub.root}/#{path}"

.run ($rootScope,   $state,   $stateParams, ActivedHubsStatus) ->
  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
  ActivedHubsStatus.add 'resourcehub', do
    name: 'Resource Hub'  
    url: '/resourcehub/home'
  ActivedHubsStatus.add 'projecthub', do
    name: 'Project Hub'  
    url: '/projecthub/home'
  ActivedHubsStatus.default 'projecthub'  
