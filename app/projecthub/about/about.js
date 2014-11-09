angular.module('ohmyhub.projecthub.about', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('project_about', {
    title: 'Project Hub - About',
    url: '/projecthub/about',
    hub: {
      name: "Project Hub",
      root: "/projecthub"
    },
    controller: 'ProjecthubAboutCtrl',
    templateUrl: 'app/projecthub/about/about.html'
  });
}).controller('ProjecthubAboutCtrl', function($scope){});