var Preloader = (function() {
  var preloads = [];
  return {
    load: function(images) {
      for (i in images) { (new Image()).src = images[i]; }
    }
  }
})();

Preloader.load(typeof preloads == 'object' ? preloads : []);