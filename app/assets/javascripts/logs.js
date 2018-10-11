$(document).ready(function() {
    if (document.getElementById('something')) {
      var source = new EventSource('/something');
      source.onmessage = function(e) {
        document.getElementById('something').innerHTML += e.data + '<br>';
        window.scrollTo(0, document.body.scrollHeight || document.getElementById('something').scrollHeight);
      };
    }
});
