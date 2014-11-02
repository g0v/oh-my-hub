angular.module('OhMyHub.nav', ['ui.router']).factory('NavFilters', function(){
  var filters;
  filters = {
    attributes: {},
    search_text: null,
    indicators: []
  };
  return {
    get: function(){
      return filters;
    },
    add: function(c, v){
      console.log("Added filter attribute: " + v);
      if (filters.attributes[c] == null) {
        filters.attributes[c] = [];
      }
      if (!in$(v, filters.attributes[c])) {
        filters.attributes[c].push(v);
        return filters.indicators.push({
          name: v,
          category: c
        });
      } else {
        throw "should not add a duplicated attribute into filters.";
      }
    },
    del: function(c, v){
      if (filters.attributes[c] != null && filters.attributes[c].length > 0) {
        console.log("Removed filter attribute: " + v);
        filters.attributes[c].splice(filters.attributes[c].indexOf(v), 1);
        filters.indicators.splice(filters.indicators.indexOf({
          name: v,
          category: c
        }), 1);
        if (filters.attributes[c].length === 0) {
          delete filters.attributes[c];
          return filters.indicators = [];
        }
      } else {
        throw "should not remove a attribute from empty filters.";
      }
    }
  };
}).factory('NavMenu', function(){
  var menu, counts, toggle;
  menu = {};
  counts = {};
  toggle = {
    switcher: true
  };
  return {
    create: function(projects){
      var i$, len$, project, j$, ref$, len1$, attrname, attrval, k$, len2$, val;
      for (i$ = 0, len$ = projects.length; i$ < len$; ++i$) {
        project = projects[i$];
        for (j$ = 0, len1$ = (ref$ = ['category', 'type', 'tag', 'tool', 'license']).length; j$ < len1$; ++j$) {
          attrname = ref$[j$];
          toggle[attrname] = false;
          attrval = project[attrname] || [];
          if (menu[attrname] == null) {
            menu[attrname] = {};
            counts[attrname] = 0;
          }
          for (k$ = 0, len2$ = attrval.length; k$ < len2$; ++k$) {
            val = attrval[k$];
            if (menu[attrname][val] == null) {
              menu[attrname][val] = 1;
            } else {
              menu[attrname][val] += 1;
            }
            if (menu[attrname]) {
              counts[attrname] = Object.keys(menu[attrname]).length;
            }
          }
        }
      }
      return [menu, counts, toggle];
    }
  };
}).controller('NavCtrl', function($scope, $location, NavMenu, NavFilters, Projects){
  $scope.filters = NavFilters.get();
  return Projects.get(function(projects){
    var ref$, menu, counts, toggle;
    ref$ = NavMenu.create(projects), menu = ref$[0], counts = ref$[1], toggle = ref$[2];
    $scope.counts = counts;
    $scope.menu = menu;
    $scope.toggle = toggle;
    $scope.goto = function(it){
      return $location.path(it);
    };
    return $scope.toggleFilter = function(c, v){
      if ($location.path !== '/project') {
        $scope.goto('/project');
      }
      if ($scope.filters.attributes[c] != null && in$(v, $scope.filters.attributes[c])) {
        return NavFilters.del(c, v);
      } else {
        return NavFilters.add(c, v);
      }
    };
  });
});
function in$(x, xs){
  var i = -1, l = xs.length >>> 0;
  while (++i < l) if (x === xs[i]) return true;
  return false;
}