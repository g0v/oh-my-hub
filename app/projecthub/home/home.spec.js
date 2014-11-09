var expect;
expect = chai.expect;
describe('ProjectHub Home module', function(){
  beforeEach(function(){
    return module('ohmyhub.projecthub.home');
  });
  describe('Projects.get', function(){
    var x$, httpbackend;
    x$ = it;
    beforeEach(function(){
      return inject(function($httpBackend){
        httpbackend = $httpBackend;
        return expect(httpbackend).to.be.ok;
      });
    });
    x$('should provide all projects.', function(done){
      httpbackend.when('GET', '/assests/projects-list.json').respond([{
        name: 'Project A'
      }]);
      httpbackend.expectGET('/assests/projects-list.json');
      return inject(function(Projects){
        Projects.get().success(function(it){
          return expect(it).to.deep.eq([{
            name: 'Project A'
          }]);
        });
        httpbackend.flush();
        return done();
      });
    });
    return x$;
  });
  return describe('ProjectHubProjectsCtrl controller', function(){
    var controller, scope;
    beforeEach(function(){
      return inject(function($controller, $rootScope){
        controller = $controller;
        return scope = $rootScope.$new();
      });
    });
    return describe('gets projects.', function(){
      var x$;
      x$ = it;
      x$('should expose in curent scope.', function(done){
        var attrs;
        attrs = {
          $scope: scope,
          Projects: {
            get: function(){
              return {
                success: function(f){
                  f([1]);
                  return {
                    error: function(f){}
                  };
                }
              };
            }
          }
        };
        controller('ProjectHubHomeCtrl', attrs);
        expect(scope.projects).to.be.deep.eq([1]);
        return done();
      });
      x$('should alert if fetching failed.', function(done){
        var attrs;
        attrs = {
          $scope: scope,
          Projects: {
            get: function(){
              return {
                success: function(){
                  return {
                    error: function(f){
                      return f('error');
                    }
                  };
                }
              };
            }
          }
        };
        controller('ProjectHubHomeCtrl', attrs);
        expect(scope.alerts).to.eq('error');
        expect(scope.projects).to.deep.eq([]);
        return done();
      });
      return x$;
    });
  });
});