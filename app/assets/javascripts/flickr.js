$(document).ready(function() {

  $('#flickr_search').hide();

  $('.flickr_load').on('click', function(){
    $('#flickr_search').show();
    // $('.flickr_load').hide();
  });

  $("ul").on('click', 'li', function() {
    var li = $(this);
    var scr = li.find('img').attr('src');
    alert(scr);
  });
});
