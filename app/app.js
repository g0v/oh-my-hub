angular.module('OhMyHub', ['OhMyHub.project', 'OhMyHub.wiki', 'OhMyHub.about', 'OhMyHub.nav', 'ui.router']).config(function($stateProvider, $urlRouterProvider){
  $(".ui.dropdown").dropdown();
  $(".ui.accordion").accordion();
  return $urlRouterProvider.otherwise('/project');
}).controller('AppCtrl', function($scope, $location){}).run([
  '$rootScope', '$state', '$stateParams', function($rootScope, $state, $stateParams){
    $rootScope.$state = $state;
    return $rootScope.$stateParams = $stateParams;
  }
]);