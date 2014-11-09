expect = chai.expect
describe 'Common module', ->
  beforeEach ->
    module 'ohmyhub.common'
  describe 'ActivedHubsStatus', -> 
    describe 'mangages status of hubs activation.', -> ``it``
      .. 'should record each hub info.', (done) ->
        ActivedHubsStatus <- inject
        info = do
          name: 'Project Hub'
        ActivedHubsStatus.add 'projecthub', info
        expect ActivedHubsStatus.get!.hubs .to.be.deep.eq projecthub: info
        done!
  describe 'HubMenu', ->
    describe 'creats a menubar.', -> ``it``
      .. 'should includes menu items, toggle status and meta info.', (done) ->
        HubMenu <- inject
        items = [
          * tag: <[t1 t2 t3]>, name: 1
          * tag: <[t1 t4]>, name: 1
          * tag: <[t1 t4]>, name: 1
          * tag: <[t1 t4]> , name: 1
          * tag: <[t5]> , name: 1
        ]
        [menu, counts, status] = HubMenu.create items, <[tag]>
        expect status.toggle.switch .to.be.not.ok
        expect status.toggle.tag .to.be.not.ok
        expect menu.tag.t1 .to.eq 4
        expect menu.tag.t2 .to.eq 1
        expect menu.tag.t4 .to.eq 3
        expect counts.tag .to.eq 5
        done!
