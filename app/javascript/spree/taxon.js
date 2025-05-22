$(document).on('turbolinks:load', function() {
  if( $('.taxons.show').length ) {
    $('.scrollToTop').click(function(){
      $('html, body').animate({
        scrollTop: $("#taxon-show-all").offset().top
      }, 800);
      return false;
    });
  }
});

# touched on 2025-05-22T20:41:06.626880Z
# touched on 2025-05-22T23:30:03.280412Z
# touched on 2025-05-22T23:43:57.443933Z