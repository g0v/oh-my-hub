angular.module('OhMyHub.project', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('project', {
    title: 'project',
    url: '/project',
    controller: 'ProjectCtrl',
    templateUrl: 'app/project/project.html'
  });
}).factory('Projects', function($http){
  return {
    get: function(done){
      console.log("pulling project list.");
      return $http.get('assests/project-list.json', {
        cache: true
      }).success(function(it){
        console.log("synced project list.");
        return done(it);
      }).error(function(it){
        console.error(it);
        return done([]);
      });
    }
  };
}).controller('ProjectCtrl', function($scope, NavFilters, Projects){
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
  $scope.toggle = {
    detail: false
  };
  $scope.filters = NavFilters.get();
  $scope.delFilter = NavFilters.del;
  return Projects.get(function(projects){
    $scope.projects = projects;
    return $scope.showDetail = function(detail){
      $scope.detail = detail;
      return $scope.toggle.detail = true;
    };
  });
});