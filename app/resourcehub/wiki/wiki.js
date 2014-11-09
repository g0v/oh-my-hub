angular.module('ohmyhub.resourcehub.wiki', ['ui.router']).config(function($stateProvider){
  return $stateProvider.state('resource_wiki', {
    title: 'Resource Hub - Wiki',
    url: '/resourcehub/wiki',
    hub: {
      name: "Resource Hub",
      root: "/resourcehub"
    },
    controller: 'ResourcehubWikiCtrl',
    templateUrl: 'app/resourcehub/wiki/wiki.html'
  });
}).controller('ResourcehubWikiCtrl', function($scope){});