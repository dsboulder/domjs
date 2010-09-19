_ = _ || {};
_.rand = function(array) {
  var len = array.length;
  var idx = Math.floor(Math.random() * len);
  return array[idx];
}