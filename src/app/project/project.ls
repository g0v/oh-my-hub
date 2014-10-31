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

.controller \ProjectCtrl, ($scope) ->
  $scope.projects = [
    * name: "KittyBall"
      description: """fdsiofhidsohfiosfhiodshfiodshfiosdhiohdsiofhdosif
      dffihdsoifhdsiofhdsiofhidosfdsofhidsofhdsiohio0
      """
      achievements: [
        * name: 'Web'
          link: 'http://www.google.com'
      ]
  ] 

  $scope.filters = [
      * name: '電子商務'
      * name: '種子階段'
      * name: '獨資'
  ]

  $scope.projects_count = do
      current: $scope.projects.length
      total: $scope.projects.length  
