var expect;
expect = chai.expect;
describe('Common module', function(){
  beforeEach(function(){
    return module('ohmyhub.common');
  });
  describe('ActivedHubsStatus', function(){
    return describe('mangages status of hubs activation.', function(){
      var x$;
      x$ = it;
      x$('should record each hub info.', function(done){
        return inject(function(ActivedHubsStatus){
          var info;
          info = {
            name: 'Project Hub'
          };
          ActivedHubsStatus.add('projecthub', info);
          expect(ActivedHubsStatus.get().hubs).to.be.deep.eq({
            projecthub: info
          });
          return done();
        });
      });
      return x$;
    });
  });
  return describe('HubMenu', function(){
    return describe('creats a menubar.', function(){
      var x$;
      x$ = it;
      x$('should includes menu items, toggle status and meta info.', function(done){
        return inject(function(HubMenu){
          var items, ref$, menu, counts, status;
          items = [
            {
              tag: ['t1', 't2', 't3'],
              name: 1
            }, {
              tag: ['t1', 't4'],
              name: 1
            }, {
              tag: ['t1', 't4'],
              name: 1
            }, {
              tag: ['t1', 't4'],
              name: 1
            }, {
              tag: ['t5'],
              name: 1
            }
          ];
          ref$ = HubMenu.create(items, ['tag']), menu = ref$[0], counts = ref$[1], status = ref$[2];
          expect(status.toggle['switch']).to.be.not.ok;
          expect(status.toggle.tag).to.be.not.ok;
          expect(menu.tag.t1).to.eq(4);
          expect(menu.tag.t2).to.eq(1);
          expect(menu.tag.t4).to.eq(3);
          expect(counts.tag).to.eq(5);
          return done();
        });
      });
      return x$;
    });
  });
});