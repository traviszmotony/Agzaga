$(document).on('turbolinks:load', function() {
  if($('.pages.faq, .pages.privacy_policy').length) {
    $('.question').on('click', function() {
      $('.card.active').removeClass('active');
      $(this).attr("aria-expanded") === 'false' && $(this).parents('.card').addClass('active');
    });

    $('.link_to_question').on('click', function() {
      var parentclass = $(this).parents().find('div.card.active')
      $('#' + parentclass.children()[1].id).removeClass('show');
      $('#' + parentclass.children()[0].id).attr("aria-expanded","false");
      $('html,body').animate({ scrollTop: $('.' + $(this).data('target').split('#')[1]).offset().top  - 80},'slow');
      $('.'+$(this).data('target').split('#')[1]).find('.card').addClass('active');
    });
  }

  if( $('.contacts.new').length ) {
    $('.message_submit').css('display', 'none');
    $("#submitButton").click(function() {
      var form = $("#contact-form");

      if (form[0].checkValidity() === false) {
        event.preventDefault();
        event.stopPropagation();
      }

      form.addClass('was-validated')
    });
  }

  if( $('.pages.mill').length ) {
    $('.mill-products-by-categories').owlCarousel({
      loop: true,
      margin: -10,
      nav: true,
      checkVisible: false,
      responsiveClass: true,
      navText: [],
      dots: false,
      center: true,
      responsive: {
        0: {
          items: 1,
          stagePadding: 12,
          nav: false,
        },
        445: {
          items: 1,
          stagePadding: 18,
          nav: false,
        },
        460: {
          items: 1,
          stagePadding: 36,
          nav: false,
        },
        500: {
          items: 1,
          stagePadding: 54,
          nav: false,
        },
        560: {
          items: 1,
          stagePadding: 72,
          nav: false,
        },
        600: {
          items: 1,
          stagePadding: 108,
          nav: false,
        },
        680: {
          items: 1,
          stagePadding: 144,
          nav: false,
        },
        760: {
          items: 1,
          stagePadding: 180,
          nav: false,
        },
        820: {
          items: 1,
          stagePadding: 216,
          nav: false,
        },
        910: {
          items: 1,
          stagePadding: 252,
          nav: false,
        },
        992: {
          items: 2,
          stagePadding: 0
        },
        1050: {
          items: 2,
          stagePadding: 36
        },
        1130: {
          items: 2,
          stagePadding: 72
        },
        1220: {
          items: 2,
          stagePadding: 108
        },
        1280: {
          items: 2,
          stagePadding: 144
        },
        1350: {
          items: 3
        }
      }
    });

    $('.latest-products').owlCarousel({
      loop: true,
      margin: 0,
      stagePadding: 32,
      nav: false,
      checkVisible: false,
      responsiveClass: true,
      navText: [],
      dots: false,
      center:true,
      responsive: {
        0: {
          items: 1,
          stagePadding: 32
        },
        400: {
          items: 1,
          stagePadding: 42
        },
        500: {
          items: 1,
          stagePadding: 100
        },
        570: {
          items: 1,
          stagePadding: 150
        },
        650: {
          items: 1,
          stagePadding: 200
        },
        768: {
          items: 0
        }
      }
    });

    $('.mill-certified-products').owlCarousel({
      loop: true,
      margin: 0,
      stagePadding: 32,
      nav: false,
      checkVisible: false,
      responsiveClass: true,
      navText: [],
      dots: false,
      center:true,
      responsive: {
        0: {
          items: 1,
          stagePadding: 32
        },
        400: {
          items: 1,
          stagePadding: 42
        },
        500: {
          items: 1,
          stagePadding: 100
        },
        570: {
          items: 1,
          stagePadding: 150
        },
        650: {
          items: 1,
          stagePadding: 200
        },
        768: {
          items: 0
        }
      }
    });
  }

  if( $('.pages.faq_page').length ) {

    $('#faq-search-input').on('input', function() {

      if ( $(this).val().length == 0 ) {
        $('.search-control-div').show();

      } else {
        var search_str = $(this).val().toLowerCase();;
        $('.search-control-div').show();

        $('.search-control-div').each( function() {
          if($(this).find('.search-text').text().trim().toLowerCase().includes(search_str) !== true) {
            $(this).hide();
          }
        });

        if($('.search-control-div:visible').length) {
          $('.faq-search-box').removeClass('ag-input-destructive').addClass('ag-input-neutral');
          $('.no-question-block').hide();
        } else {
          $('.faq-search-box').removeClass('ag-input-neutral ').addClass('ag-input-destructive');
          $('.no-question-block').show();
        }
      }
    });

    $('.support-message').on('click', function(){
      if(!$('.contact-us-form:visible').length) {
        $('#firstname, #lastname, #email, #message').val('')
        $('.contact-us-form').show();
        $('#new-form-success-message').removeClass('show-thank-you-message').addClass('hide-element');
      }
      $('input[name="firstname"]').focus();
    });

    $(document).on('click', '.close-alert-section', function() {
      $('.faq-search-box').removeClass('ag-input-destructive').addClass('ag-input-neutral');
      $('.faq-search-input').val('');
      $('.no-question-block').hide();
      $('.search-control-div').show();
    });

    if(window.location.hash == '#question-6') {
      $("#question-6").attr("aria-expanded", "true");
      $("#answer-6").addClass("show");
    }

    $('.contact-support-team').on('click', function(){
      $('#contact-support-section')[0].scrollIntoView();
    });
  }

  if( $('.pages.shipping_policy').length ) {
    var url = window.location.href.split('#')

    if (url[1] == 'custom-product-returns'){
      $("#custom-product-returns").attr("aria-expanded","true");
      $('#answer-8').addClass('show')
    }
  }

  if( $('.products.gift_page').length ) {
    $(document).on('click','#expand-text', {} ,function(e){
      if ($(this).children('.arrow-collapse')[0].classList.contains('rotate')) {
        $(this).children('.arrow-collapse')[0].classList.remove('rotate')
      }
      else {
        $(this).children('.arrow-collapse')[0].classList.add('rotate')
      }
    });
  }
});

# touched on 2025-05-22T20:38:24.232175Z
# touched on 2025-05-22T22:47:11.780577Z
# touched on 2025-05-22T23:00:00.000997Z