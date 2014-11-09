expect = chai.expect
describe 'ProjectHub Home module', ->
  beforeEach ->
    module 'ohmyhub.projecthub.home'
  describe 'Projects.get', -> ``it``
    var httpbackend 
    beforeEach ->
      $httpBackend <- inject
      httpbackend := $httpBackend
      expect httpbackend .to.be.ok 
    .. 'should provide all projects.', (done) ->
      httpbackend
        .when 'GET', '/assests/projects-list.json'
        .respond [{name: 'Project A'}]
      httpbackend.expectGET '/assests/projects-list.json'
      Projects <- inject
      Projects.get!success -> expect it .to.deep.eq [{name:'Project A'}]
      httpbackend.flush!
      done!
  describe 'ProjectHubProjectsCtrl controller', -> 
    var controller, scope
    beforeEach ->
      $controller, $rootScope <- inject
      controller := $controller
      scope := $rootScope.$new!
    describe 'gets projects.', -> ``it``
      .. 'should expose in curent scope.', (done) ->
        attrs = do
          $scope: scope
          Projects: do
            get: -> do
              success: (f) -> 
                f [1]
                return error: (f) -> 
        controller 'ProjectHubHomeCtrl', attrs
        expect scope.projects .to.be.deep.eq [1]
        done!
      .. 'should alert if fetching failed.', (done) ->
        attrs = do
          $scope: scope
          Projects: do
            get: -> do
              success: -> 
                return error: (f) -> f 'error'
        controller 'ProjectHubHomeCtrl', attrs
        expect scope.alerts .to.eq 'error'
        expect scope.projects .to.deep.eq []
        done!        
