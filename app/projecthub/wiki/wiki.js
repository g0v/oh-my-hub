angular.module('ohmyhub.projecthub.wiki', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('projecthub_wiki', {
    title: 'Project Hub - Wiki',
    url: '/projecthub/wiki',
    hub: {
      name: "Project Hub",
      root: '/projecthub'
    },
    controller: 'ProjecthubWikiCtrl',
    templateUrl: 'app/projecthub/wiki/wiki.html'
  });
}).controller('ProjecthubWikiCtrl', function($scope){});