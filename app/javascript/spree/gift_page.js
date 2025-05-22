$(document).on('turbolinks:load', function() {

  if($('.products.gift_page').length){
    $('.show-more-content').on('click', function() {
      if($(this).parent().find('.more-content:visible').length) {
        $(this).parent().find('.more-content').removeClass('show-content');
        $(this).removeClass('show-less').addClass('show-more');
        $(this).text('More Info');
      } else {
        $(this).parent().find('.more-content').addClass('show-content');
        $(this).removeClass('show-more').addClass('show-less');
        $(this).text('Less Info');
      }
    });
  }
});

# touched on 2025-05-22T19:19:05.970777Z
# touched on 2025-05-22T22:32:59.851819Z