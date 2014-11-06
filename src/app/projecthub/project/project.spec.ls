expect = chai.expect
describe 'Project module', ->
  beforeEach ->
    module('OhMyHub.project')
  describe "filterProject", -> ``it``	
    var filterProject
    beforeEach ->
      $filter <- inject
      filterProject := $filter 'filterProject'
      expect filterProject .to.be.ok
    .. "should reject project without applied conditions.", (done) -> 
      conds = {category:<[C1]>}
      filtered = filterProject [{category:<[C1]>}, {category:<[C2]>}], conds
      expect filtered .to.deep.eq [{category:<[C1]>}]

      conds = {category:<[C1 C2]>}
      filtered = filterProject [{category:<[C1 C2]>}, {category:<[C1 C2]>}], conds
      expect filtered .to.deep.eq [{category:<[C1 C2]>}, {category:<[C1 C2]>}]      

      conds = {category:<[C1]>, tag:<[T1]>}
      filtered = filterProject [{category:<[C1]>, tag:[]}, {category:<[C1]>, tag:<[T1]>}], conds
      expect filtered .to.deep.eq [{category:<[C1]>, tag:<[T1]>}]

      conds = {category:<[C1]>, tag:<[T1]>}
      filtered = filterProject [{category:<[C1]>, tag:[]}, {category:<[C1]>, tag:<[T1 T2 T3]>}], conds
      expect filtered .to.deep.eq [{category:<[C1]>, tag:<[T1 T2 T3]>}]      

      conds = {tag:<[T1 T2]>}
      filtered = filterProject [{tag:<[T1 T2]>}, {tag:<[T1]>}], conds
      expect filtered .to.deep.eq [{tag:<[T1 T2]>}, {tag:<[T1]>}]         

      conds = {tag:<[T1 T2]>}
      filtered = filterProject [{name:<[T1 T2]>}, {tag:<[T1]>}], conds
      expect filtered .to.deep.eq [{tag:<[T1]>}]
      done!