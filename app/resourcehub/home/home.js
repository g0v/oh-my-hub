angular.module('ohmyhub.resourcehub.home', ['ohmyhub.common', 'ui.router']).factory('Resources', function($http){
  return {
    get: function(){
      return $http.get('/assests/resources-list.json');
    }
  };
}).config(function($stateProvider){
  return $stateProvider.state('resourcehub_home', {
    title: 'Resource Hub - Home',
    url: '/resourcehub/home',
    hub: {
      name: 'Resource Hub',
      root: '/resourcehub'
    },
    controller: 'ResourceHubHomeCtrl',
    templateUrl: 'app/resourcehub/home/home.html'
  });
}).controller('ResourceHubHomeCtrl', function($scope, HubMenu, Resources, FiltersStore){
  $scope.filters = FiltersStore.get();
  $scope.resources = [];
  $scope.alerts = null;
  return Resources.get().success(function(it){
    var ref$, menu, counts, status;
    $scope.resources = it;
    ref$ = HubMenu.create($scope.resources, ['type', 'license']), menu = ref$[0], counts = ref$[1], status = ref$[2];
    $scope.$parent.menu = menu;
    $scope.$parent.counts = counts;
    return $scope.$parent.toggle = status.toggle;
  }).error(function(it){
    return $scope.alerts = it;
  });
});