angular.module('ohmyhub.resourcehub.about', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('resourcehub_about', {
    title: 'Resource Hub - About',
    url: '/resourcehub/about',
    hub: {
      name: "Resource Hub"
    },
    controller: 'ResourcehubAboutCtrl',
    templateUrl: 'app/resourcehub/about/about.html'
  });
}).controller('ResourcehubAboutCtrl', function($scope){});