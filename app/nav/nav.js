angular.module('ohmyhub.nav', ['ohmyhub.common', 'ui.router']).controller('NavCtrl', function($scope, $location, ActivedHubsStatus, FiltersStore){
  $(".ui.dropdown").dropdown();
  $(".ui.accordion").accordion();
  $scope.activedhubs = ActivedHubsStatus.get();
  $scope.filters = FiltersStore.get();
  return $scope.toggleFilter = function(c, v){
    if (!/home/.test($location.$$path)) {
      $scope.goto('home');
    }
    if ($scope.filters.attributes[c] != null && in$(v, $scope.filters.attributes[c])) {
      return FiltersStore.del(c, v);
    } else {
      return FiltersStore.add(c, v);
    }
  };
});
function in$(x, xs){
  var i = -1, l = xs.length >>> 0;
  while (++i < l) if (x === xs[i]) return true;
  return false;
}