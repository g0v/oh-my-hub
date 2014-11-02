angular.module('OhMyHub.wiki', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('wiki', {
    title: 'wiki',
    url: '/wiki',
    controller: 'WikiCtrl',
    templateUrl: 'app/wiki/wiki.html'
  });
}).controller('WikiCtrl', function($scope){});