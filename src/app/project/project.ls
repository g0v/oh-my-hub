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

.controller \ProjectCtrl, ($scope, $http) ->
  $http.get 'http://localhost:3333/assests/project-list.json'
    .success (data) ->
      $scope.projects = data

      $scope.filters = [
          * name: '電子商務'
          * name: '種子階段'
          * name: '獨資'
      ]

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

      $scope.projects_count = do
          current: $scope.projects.length
          total: $scope.projects.length  
