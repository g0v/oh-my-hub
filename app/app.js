angular.module('ohmyhub', ['ohmyhub.common', 'ohmyhub.resourcehub', 'ohmyhub.projecthub', 'ohmyhub.nav', 'ui.router']).config(function($stateProvider, $urlRouterProvider){
  return $urlRouterProvider.otherwise('/resourcehub/home');
}).controller('AppCtrl', function($scope, $state, $location, FiltersStore){
  $scope.delFilter = FiltersStore.del;
  $scope.switchHub = function(huburl){
    FiltersStore.clear();
    return $location.path(huburl);
  };
  return $scope.goto = function(path){
    return $location.path($state.current.hub.root + "/" + path);
  };
}).run(function($rootScope, $state, $stateParams, ActivedHubsStatus){
  $rootScope.$state = $state;
  $rootScope.$stateParams = $stateParams;
  ActivedHubsStatus.add('resourcehub', {
    name: 'Resource Hub',
    url: '/resourcehub/home'
  });
  ActivedHubsStatus.add('projecthub', {
    name: 'Project Hub',
    url: '/projecthub/home'
  });
  return ActivedHubsStatus['default']('projecthub');
});