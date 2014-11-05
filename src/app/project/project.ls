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

.filter 'filterProject', ->
  (items, conds) -> 
    _ = require 'prelude-ls'  
    contains-any-attr = -> 
      _.and-list [it[k] and (_.intersection v, it[k]) .length > 0 or false for k,v of conds]
    return items |> _.filter contains-any-attr

.factory 'Projects', ($http) ->
  do 
    get: (done) -> 
      console.log "pulling project list."
      $http.get 'assests/project-list.json', {+cache}
        .success ->
          console.log "synced project list."
          done it
        .error -> 
          console.error it
          done []

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
  $scope.toggle = do 
    detail: false
  $scope.filters = NavFilters.get!
  $scope.delFilter = NavFilters.del
  $scope.projects <- Projects.get!
  $scope.showDetail = (detail) ->
    $scope.detail = detail
    $scope.toggle.detail = true
