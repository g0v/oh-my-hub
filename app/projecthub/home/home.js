angular.module('ohmyhub.projecthub.home', ['ohmyhub.common', 'ui.router']).factory('Projects', function($http){
  return {
    get: function(done){
      return $http.get('/assests/projects-list.json');
    }
  };
}).config(function($stateProvider){
  return $stateProvider.state('projecthub_home', {
    title: 'Project Hub - Home',
    url: '/projecthub/home',
    hub: {
      name: 'Project Hub',
      root: '/projecthub'
    },
    controller: 'ProjectHubHomeCtrl',
    templateUrl: 'app/projecthub/home/home.html'
  });
}).controller('ProjectHubHomeCtrl', function($scope, Projects, HubMenu, FiltersStore){
  $scope.filters = FiltersStore.get();
  $scope.icon_css = {
    "Android": "android",
    "iOS": "apple",
    "WP": "windows",
    "Firefox OS": "mobile",
    "Mac": "apple",
    "Linux": "linux",
    "Windows": "windows",
    "Firefox": "browser",
    "Chrome": "browser",
    "Safari": "browser",
    "API": "setting",
    "Document": "text file",
    "Media": "bullhorn"
  };
  $scope.projects = [];
  $scope.alerts = null;
  return Projects.get().success(function(it){
    var ref$, menu, counts, status;
    $scope.projects = it;
    ref$ = HubMenu.create($scope.projects, ['category', 'tag', 'tool', 'license']), menu = ref$[0], counts = ref$[1], status = ref$[2];
    $scope.$parent.menu = menu;
    $scope.$parent.counts = counts;
    $scope.$parent.toggle = status.toggle;
    $scope.toggle.detail = false;
    return $scope.showDetail = function(it){
      $scope.toggle.detail = true;
      return $scope.detail = it;
    };
  }).error(function(it){
    return $scope.alerts = it;
  });
});