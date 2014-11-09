angular.module 'ohmyhub.nav', <[
  ohmyhub.common		
  ui.router
]>

.controller \NavCtrl, ($scope, $location, ActivedHubsStatus, FiltersStore) ->
  $ ".ui.dropdown" .dropdown!
  $ ".ui.accordion" .accordion!
  $scope.activedhubs = ActivedHubsStatus.get!
  $scope.filters = FiltersStore.get!
  $scope.toggleFilter = (c, v) ->
    if $location.$$path isnt /home/
      $scope.goto 'home'
    if $scope.filters.attributes[c]? and v in $scope.filters.attributes[c]
      FiltersStore.del c, v
    else
      FiltersStore.add c, v  
