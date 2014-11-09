var expect;
expect = chai.expect;
describe('App', function(){
  beforeEach(function(){
    return module('ohmyhub');
  });
  return describe("actives hubs automatically.", function(){
    var x$, activedhubs;
    x$ = it;
    beforeEach(function(){
      return inject(function(ActivedHubsStatus){
        return activedhubs = ActivedHubsStatus.get();
      });
    });
    x$('should includes Project Hub.', function(done){
      expect(activedhubs.hubs.projecthub).to.be.ok;
      expect(activedhubs['default']).to.deep.eq({
        name: 'Project Hub',
        url: '/projecthub/home'
      });
      return done();
    });
    return x$;
  });
});