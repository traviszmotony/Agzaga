$(document).on('turbolinks:load', function() {
  window.onscroll = function() {
    if ($('.footer_v2').length > 0) {
      var $el = $('.footer_v2'),
        scrollTop = $(this).scrollTop(),
        scrollBot = scrollTop + $(this).height(),
        elTop = $el.offset().top,
        elBottom = elTop + $el.outerHeight(),
        visibleTop = elTop < scrollTop ? scrollTop : elTop,
        visibleBottom = elBottom > scrollBot ? scrollBot : elBottom;
        value = visibleBottom - visibleTop + 40;
        if (visibleBottom  - visibleTop >= 0) {
          $('.hsds-beacon .htpUky').css('bottom', value+'px');
        }
        else {
          $('.hsds-beacon .htpUky').css('bottom', '40px');
        }
      }
  }
});


# touched on 2025-05-22T22:39:03.206696Z
# touched on 2025-05-22T23:25:38.931581Z
# touched on 2025-05-22T23:28:55.949204Z