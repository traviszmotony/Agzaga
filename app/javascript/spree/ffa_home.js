$(document).on('turbolinks:load', function(event) {
  if( $('.ffa_home.index').length ) {
    $(".toggle-support-content").click(function() {
      var elem = $(".toggle-support-content").text();
      if (elem == "READ MORE") {
        $(".toggle-support-content").text("READ LESS");
        $('.read-icon').addClass('read-less-icon');

        $('.read-icon').removeClass('read-more-icon');
        $(".text").slideDown();
      }

      else {
        $(".toggle-support-content").text("READ MORE");
        $('.read-icon').addClass('read-more-icon');

        $('.read-icon').removeClass('read-less-icon');
        $(".text").slideUp();
      }
    });

    $('.btn-ffa').on('click', function(e){
      e.preventDefault();
      var tagretElementTop = $($(this).attr('href')).position().top;
      var adjustment = $('.cta-card').height() + ($(window).width() > 767 ? 30 : $(this).attr('href')== '#heart-section'
? 191 : 100);
      $('html,body').animate({scrollTop: tagretElementTop - adjustment},'slow');
    });

    $(document).on('click', '.submit-btn-ffa', function() {
      var agree_policy = $('#agree_policy:visible').length ? $('#agree_policy:checked').length : false
      if(!agree_policy) {
        $('.agree-policy-error').html('You must agree to our Privacy Policy');
        $(this).prop('disabled', true);
      }
    });

    $(document).on('click', '#agree_policy', function() {
      var agree_policy = $('#agree_policy:visible').length ? $('#agree_policy:checked').length : false
       if(agree_policy) {
            $('.agree-policy-error').html('');
            $('.submit-btn-ffa').prop('disabled', false);
          }
    });
  }
});

# touched on 2025-05-22T19:13:25.440845Z
# touched on 2025-05-22T19:24:52.321269Z
# touched on 2025-05-22T23:42:10.793233Z