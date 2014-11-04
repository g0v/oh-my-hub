expect = chai.expect
describe 'Nav module', ->
  beforeEach ->
    module 'OhMyHub.nav'
  describe "NavMenu", -> ``it``
    .. "shows categories with counts.", (done) ->
      attrs = <[category type tag tool license]>
      NavMenu <- inject
      [menu, counts, toggle] = NavMenu.create [      
        * name: 1
        * name: 2
        * name: 3
      ]
      for I in attrs
        expect counts[I] .to.eq 0
        expect menu[I] .to.deep.eq {}

      for I in attrs
        [menu, counts, toggle] = NavMenu.create [
          * "#I": <[C1]>
          * "#I": <[C2]>
          * "#I": <[C2]>
          * "#I": <[C3]>
          * name: 1
        ]
        expect toggle.switch .to.be.not.ok
        expect toggle[I] .to.be.not.ok
        expect counts[I] .to.eq 3
        expect menu[I].C1 .to.eq 1
        expect menu[I].C2 .to.eq 2
      done!
  describe "NavFilter service", -> ``it``
    .. 'indicats current applied conditions.', (done) -> 
      NavFilters <- inject 
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
  describe 'NavFilters.add', -> ``it``
    .. "should catch invalid arguments.", (done) ->
      NavFilters <- inject
      expect (-> NavFilters.add null, 'condition is given') .to.throw Error
      expect (-> NavFilters.add 'category is given', null) .to.throw Error
      expect NavFilters.get!indicators.length .to.eq 0
      expect NavFilters.get!attributes .to.deep.eq {}
      done!
    .. "should catch duplicate conditions.", (done) ->
      NavFilters <- inject 
      NavFilters.add "category", "Attr1"
      expect (-> NavFilters.add "category", "Attr1") .to.throw Error
      expect NavFilters.get!indicators.length .to.eq 1
      done!
  describe 'NavFilters.del', -> ``it``
    .. "should catch invalid arguments.", (done) -> 
      NavFilters <- inject
      expect (-> NavFilters.del null, 'condition is given') .to.throw Error
      expect (-> NavFilters.del 'category is given', null) .to.throw Error
      done!
    .. "should catch removing a condition from a empty filters.", (done) ->
      NavFilters <- inject
      expect (-> NavFilters.del "category", "Attr1") .to.throw Error
      done!
  describe 'NavCtrl', -> ``it``    
    var scope, ctrl
    beforeEach (done) ->
      $rootScope, $controller <- inject
      scope := $rootScope.$new!
      ctrl := $controller
      done!
    .. "get empty items.", (done) ->
      ctrl 'NavCtrl', $scope: scope, Projects: get: (done) -> done []
      expect scope.menu .to.deep.eq {}
      expect scope.counts .to.deep.eq {}
      done!
    .. "get items in valid format.", (done) ->
      res = [
        * category: <[C1]>
        * category: <[C1]>
        * category: <[C1]>
      ]
      ctrl 'NavCtrl', $scope: scope, Projects: get : (done) -> done res
      expect scope.menu.category.C1 .to.eq 3
      expect scope.counts.category .to.eq 1
      done!
