angular.module('OhMyHub.about', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('about', {
    title: 'about',
    url: '/about',
    controller: 'AboutCtrl',
    templateUrl: 'app/about/about.html'
  });
}).controller('AboutCtrl', function($scope){});