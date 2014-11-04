expect = chai.expect
describe 'Nav module', ->
  beforeEach ->
    module 'OhMyHub.nav'
  describe "NavFilter service", -> ``it``
    .. 'indicats current applied conditions.', (done) -> 
      inject (NavFilters, $filter) ->
        filters = NavFilters.get!
        expect filters.indicators.length .to.eq 0
        NavFilters.add 'category', 'Attr1'
        NavFilters.add 'category', 'Attr2'
        NavFilters.add 'type', 'Attr3'
        expect filters.indicators .to.deep.eq [
          * name: 'Attr1'
            category: 'category'
          * name: 'Attr2'
            category: 'category'
          * name: 'Attr3'
            category: 'type'
        ]
        NavFilters.del 'category', 'Attr1'
        expect filters.indicators .to.deep.eq [ 
          * name: 'Attr2'
            category: 'category'
          * name: 'Attr3'
            category: 'type'
        ]
        NavFilters.del 'category', 'Attr2'
        NavFilters.del 'type', 'Attr3'
        expect filters.indicators.length .to.eq 0
        expect filters.attributes .to.deep.eq {}
      done!
