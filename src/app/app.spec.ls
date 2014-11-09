expect = chai.expect
describe 'App', ->
  beforeEach ->
    module 'ohmyhub'
  describe "actives hubs automatically.", -> ``it``
    var activedhubs
    beforeEach ->
      ActivedHubsStatus <- inject
      activedhubs := ActivedHubsStatus.get!
    .. 'should includes Project Hub.', (done) ->
      expect activedhubs.hubs.projecthub .to.be.ok
      expect activedhubs.default .to.deep.eq {name:'Project Hub', url: '/projecthub/home'}
      done!
