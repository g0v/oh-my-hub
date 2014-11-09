angular.module('ohmyhub.common', []).filter('containsAnyAattr', function(){
  return function(items, conds){
    var _, containsAnyAttr;
    if (items.length > 0 && conds) {
      _ = require('prelude-ls');
      containsAnyAttr = function(it){
        var k, v;
        return _.andList((function(){
          var ref$, results$ = [];
          for (k in ref$ = conds) {
            v = ref$[k];
            results$.push(it[k] && _.intersection(v, it[k]).length > 0 || false);
          }
          return results$;
        }()));
      };
      return _.filter(containsAnyAttr)(
      items);
    } else {
      return [];
    }
  };
}).factory('FiltersStore', function(){
  var _, filters;
  _ = require('prelude-ls');
  filters = {
    attributes: {},
    indicators: []
  };
  return {
    clear: function(){
      return filters = {
        attributes: {},
        indicators: []
      };
    },
    get: function(){
      return filters;
    },
    add: function(c, v){
      if (!(c != null && v != null)) {
        throw new Erro("try to add undifined condition into filters.");
      }
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
        throw new Error("should not add a duplicated attribute into filters.");
      }
    },
    del: function(c, v){
      var ref$, ref1$;
      if (!(c != null && v != null)) {
        throw new Error("try to remove undifined condition from filters.");
      }
      if (filters.attributes[c] != null && filters.attributes[c].length > 0) {
        console.log("Removed filter attribute: " + v);
        filters.attributes[c] = _.reject(function(it){
          return angular.equals(it, v);
        }, filters.attributes[c]);
        filters.indicators = _.reject(function(it){
          return angular.equals(it, {
            name: v,
            category: c
          });
        }, filters.indicators);
        if (filters.attributes[c].length === 0) {
          return ref1$ = (ref$ = filters.attributes)[c], delete ref$[c], ref1$;
        }
      } else {
        throw new Error("should not remove a attribute from empty filters.");
      }
    }
  };
}).factory('ActivedHubsStatus', function(){
  var _default, hubs;
  _default = null;
  hubs = {};
  return {
    get: function(){
      return {
        'default': _default,
        hubs: hubs
      };
    },
    add: function(codename, info){
      return hubs[codename] = info;
    },
    'default': function(codename){
      if (hubs[codename] != null) {
        return _default = hubs[codename];
      } else {
        throw "unactived hub: " + codename;
      }
    }
  };
}).factory('HubMenu', function(){
  return {
    create: function(items, attributes){
      var menu, counts, status, i$, len$, item, j$, len1$, attrname, attrval, k$, len2$, val;
      menu = {};
      counts = {};
      status = {
        toggle: {
          'switch': false
        }
      };
      for (i$ = 0, len$ = items.length; i$ < len$; ++i$) {
        item = items[i$];
        for (j$ = 0, len1$ = attributes.length; j$ < len1$; ++j$) {
          attrname = attributes[j$];
          status.toggle[attrname] = false;
          attrval = item[attrname] || [];
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
      return [menu, counts, status];
    }
  };
});
function in$(x, xs){
  var i = -1, l = xs.length >>> 0;
  while (++i < l) if (x === xs[i]) return true;
  return false;
}