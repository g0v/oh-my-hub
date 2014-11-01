angular.module 'OhMyHub.project', <[
  ui.router
]>

.config ($stateProvider) ->
  $stateProvider
    .state 'project', do
      title: 'project'
      url: '/project'
      controller: \ProjectCtrl
      templateUrl: \app/project/project.html

.controller \ProjectCtrl, ($scope, $http, Nav) ->
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
    "Safari": "browser"
    "API": "setting",
    "Document": "text file",
    "Media":"bullhorn" 
  }    
  $scope.filters = Nav.get_filters!
  $scope.projects = []

  $http.get '/assests/project-list.json'
    .success (data) ->
      $scope.projects = data
    .error (data) -> 
      console.error data
