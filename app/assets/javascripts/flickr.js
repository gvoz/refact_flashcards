$(document).ready(function() {

  $('#flickr-search').hide();

  $('#flickr-load').on('click', function(){
    $('#flickr-search').show();
    $('#card-info').hide();
  });
});

$(document).on('click', '.flickr-image', function(){
  var img_scr = $(this).attr('src');
  $('#card_remote_image_url').val(img_scr);
  $('#image-block').show();
  $('#card-image').attr('src', img_scr);
  $('#card-info').show();
  $('#flickr-search').hide();
  $('#flickr-photos').hide();
});
