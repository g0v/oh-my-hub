angular.module 'ohmyhub.projecthub.home', <[
  ohmyhub.common
  ui.router
]>

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

.controller 'ProjectHubHomeCtrl', ($scope, HubMenu, FiltersStore, $firebase) ->
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

  ref = new Firebase 'https://oh-my-hub.firebaseio.com/projects'
  sync = $firebase ref
  $scope.projects = sync.$asArray!
  $scope.projects.$loaded!.then ->
    [menu, counts, status] = HubMenu.create $scope.projects, <[category tag tool license]>
    $scope.$parent.menu = menu
    $scope.category = Object.keys($scope.menu.category)
    $scope.license = Object.keys($scope.menu.license)
    $scope.tools = Object.keys($scope.menu.tool)
    $scope.status = ["Production", "In progress", "In Ideas"]
    $scope.needs = ["開發人員","設計師","行銷人員","數據分析"]
    $scope.$parent.counts = counts
    $scope.$parent.toggle = status.toggle
    $scope.toggle.detail = false
  $scope.showDetail = ->  
    $scope.toggle.detail = true
    $scope.index = it
   
  $scope.addProject = ->  
    $scope.projects.$add({hello: 'motto'})
    $scope.index = $scope.projects.length
    $scope.toggle.detail = true
    
  $scope.getGithubUrl = (project) ->
    if typeof(project.workspace) != 'undefined'
      for i in project.workspace
        if i.url.search(/github.com/i) > 0
          return i.url
    return null
