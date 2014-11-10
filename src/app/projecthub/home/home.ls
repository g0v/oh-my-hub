angular.module 'ohmyhub.projecthub.home', <[
  ohmyhub.common
  ui.router
]>

.factory 'Projects', ($http) ->
  do
    get: (done) -> $http.get 'assests/projects-list.json'

.config ($stateProvider) ->
  $stateProvider
    .state 'projecthub_home', do
      title: 'Project Hub - Home'
      url: '/projecthub/home'
      hub: do 
        name: 'Project Hub'
        root: '/projecthub'
      controller: 'ProjectHubHomeCtrl'
      templateUrl: 'app/projecthub/home/home.html'

.controller 'ProjectHubHomeCtrl', ($scope, Projects, HubMenu, FiltersStore) ->
  $scope.filters = FiltersStore.get!
  $scope.icon_css = do
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
  $scope.projects = []
  $scope.alerts = null

  Projects.get!
    .success -> 
      $scope.projects = it
      [menu, counts, status] = HubMenu.create $scope.projects, <[category tag tool license]>
      $scope.$parent.menu = menu
      $scope.$parent.counts = counts
      $scope.$parent.toggle = status.toggle
      $scope.toggle.detail = false
      $scope.showDetail = ->  
        $scope.toggle.detail = true
        $scope.detail = it
    .error -> 
      $scope.alerts = it
