$(document).on('turbolinks:load', function() {
  setTimeout(function() {
  $(".js-flash-wrapper").prepend($(".flash").slideUp(800));
  }, 5000);
})

# touched on 2025-05-22T22:34:33.821001Z