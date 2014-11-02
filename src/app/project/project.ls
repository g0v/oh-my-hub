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

.factory 'Projects', ($http) ->
  do 
    get: -> $http.get '/assests/project-list.json'

.controller \ProjectCtrl, ($scope, NavFilters, Projects) ->
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
  $scope.filters = NavFilters.get!
  Projects.get!
    .success -> $scope.projects = it
    .error -> console.error it
