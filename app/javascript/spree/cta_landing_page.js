$(document).on('turbolinks:load', function() {
  if($('.pages.freedom_wrap').length || $('.pages.august_event').length || $('.pages.chuckwagon_dvd').length || $('.pages.net_wraps').length || $('.pages.usa').length) {

    $(document).on('click', '.toggle-btn, #myNav.overlay', function (e) {
      var nav = $('#myNav');
      var nav_hamburger = $(".toggle-btn > img");
      if(nav.is(':visible') && !$(e.target).hasClass('overlay-left')){
        nav.hide();
        $('body').removeClass('ag-modal-open');
      } else {
        nav.show();
        $('body').addClass('ag-modal-open');
      }
    });

    var isMobileNavClicked = false;

    $(document).on('click', '.pre-nav-cross-icon', function () {
      $('.pre-nav').hide();
      isMobileNavClicked = true;
    });

    $(document).on('click', '.mobile-nav', function () {
      if ($('.pre-nav').is(':visible') || isMobileNavClicked) {
        $('.pre-nav').hide();
        if ($('.pre-nav').is(':visible')) {
          isMobileNavClicked = true;
        }
      }
      else {
        $('.pre-nav').show();
      }
    });

    $(document).on('click', '.add-pallet-to-cart-button', function() {
      var quantity = $(this).data('palletQuantity');
      var target_field = '.'+$(this).data('quantityField');
      $(target_field).val(quantity).focus();
    });

    $(document).on('click', '.mobile-search-icon', function () {
      $('.mobile-nav .search-list-box').addClass("active").show();
      $('.no-result-found').hide();
      $('.search-list-block').hide();
    });

    $(document).on('change', 'input:radio.variantid', function(){
      var price = $(this).data('price');
      var target_field = $('#' + $(this).data('updatePrice'));
      target_field.text(price);
    });

    $(document).on('click', '.contact-link', function () {
      FB.CustomerChat.showDialog();
    });

    $(document).on('click', '.cart-btn, #go-to-slider', function(e) {
      if ($(document).width() < 767) {
        return true;
      }
      e.preventDefault();
      $('#cartSlider').modal('show');
      $('#add_to_cart_v2_modal').modal('hide');
      $('.cart-slider').css('z-index', 11);
      window.disablePageScroll();
    });

    $(document).on('click', '.search-icon', function() {
      $(this).hide();
      var search_field = '#' + $(this).data('search');
      $(search_field).show();
    });
  }
});

# touched on 2025-05-22T19:14:48.414875Z
# touched on 2025-05-22T23:44:20.112321Z