$(document).on('turbolinks:load', function(event) {
  if( $('.products.show, .products.reviews_form').length || $('.pages.chuckwagon_dvd, .pages.net_wraps, .pages.usa').length ) {
    var postUrl = document.location.href;
    var postTitle = "Visit this link: ";
    window.related_products = related_products;

    var twitterBtn = $('.twitter-btn');
    var facebookBtn = $('.facebook-btn');
    var mailBtn = $('.mail-btn');

    set_locations();

    function set_locations() {
      twitterBtn.attr("href", `https://twitter.com/share?url=${postUrl}&text=${postTitle}`);
      facebookBtn.attr("href", `https://www.facebook.com/sharer.php?u=${postUrl}`);
      mailBtn.attr("href", `mailto:?subject=${postTitle}&body=${postUrl}`);
    }

    $(document).on('click', function(event) {
      if($(document).width() > 767 && !(event.target.id == 'link-share-icon' || $(event.target).hasClass('share-icons-popup'))) {
        if (!$('.share-icons-popup').hasClass("hide-popup")) {
          $('.share-icons-popup').addClass("hide-popup");
        }
      }
    });

    $("#youtube-link-clipboard-btn").on('click', function(){
      $("body").append('<input id="copyURL" type="text" value="" />');
      $("#copyURL").val($('.link-for-clipboard').first().text()).select();
      document.execCommand("Copy");
      $('#youtube-link-clipboard-btn').attr('data-original-title','Copied!');
      $("#youtube-link-clipboard-btn").tooltip('show')
    });

    $('.link-share-icon, #link-share-icon').on('click', function() {
      if($(document).width() > 767) {
        if ($('.share-icons-popup').hasClass("hide-popup")) {
          $('.share-icons-popup').removeClass("hide-popup");
        }
        else {
          $('.share-icons-popup').addClass("hide-popup");
        }
      } else {
        const btn = $(this)[0];

        function webShareAPI(header, description, link) {
          navigator
            .share({
              title: header,
              text: description,
              url: link,
            })
        }

        if (navigator.share) {
          btn.style.display = "block";
          btn.addEventListener("click", () =>
            webShareAPI("Agzaga Product Page Link", postTitle, postUrl)
          );
        } else {
          btn.style.display = "none";
        }
      }
    });

    $('#clipboard-btn').mouseover(function() {
      $("#clipboard-btn").tooltip('hide')
      $('#clipboard-btn').attr('data-original-title','');

    });

    $('#clipboard-btn').mouseout(function() {
      $("#clipboard-btn").tooltip('hide')
      $('#clipboard-btn').attr('data-original-title','');
    });

    $("#clipboard-btn").on('click', function(){
      $("body").append('<input id="copyURL" type="text" value="" />');
      $("#copyURL").val(postUrl).select();
      document.execCommand("Copy");
      $("#copyURL").remove();
      $('#clipboard-btn').attr('data-original-title','Copied!');
      $("#clipboard-btn").tooltip('show')
    });

    if( $('.products.show, .pages.net_wraps, .products.reviews_form').length) {
      $('.detail').each(function(event) {
        var text_area = $(this).find('p');
        var max_length = 300;
        var full_length = text_area.html().length;

        if(text_area.html().length > max_length) {


          var read_more = $(this).find('a.read-more');
          var read_less = $(this).find('a.read-less');
          var short_content 	= text_area.html().substr(0,max_length);
          var long_content	= text_area.html().substr(0, full_length);

          text_area.html(short_content);
          read_more.show();

          read_more.click(function(event){
            text_area.html(long_content);
            read_more.hide();
            read_less.show();
          });

          read_less.click(function(event){
            text_area.html(short_content);
            read_less.hide();
            read_more.show();
          });
        }
      });

      $('.search-tag').on('click',function() {
        $($(this).data('target')).modal('show');
        return false;
      });

      $('.review-light-gallery').lightGallery({
        thumbnail:true
      });

      $('.product-variants input[type="radio"]').on( 'input', function() {
        var variantPrice = $(this).data("price");
        if (variantPrice) {
          $(".price.selling").text(variantPrice);
        }
      });

      $('.product-question-content, .product-questioner-name').on('input', function(){
          $('.product-question-modal-content').removeClass('validation-error');
          $(".question-submit-btn").removeClass('disable_btn').addClass('btn-gradient-orange')
                                    .prop("disabled", false);

        if ( $('.product-question-content').is(":focus")) {
          $('.product-question-modal-content').removeClass('validation-error');
          $('.question-required-error').css('display', 'none');
        }

        if ($('.product-questioner-name').is(":focus") && $('.questioner-name-error').value != '')  {
          $('.questioner-name-error').css('display','none');
          $('.product-questioner-name').removeClass('error-questioner');
        }
      });

      $(document).on('click', '.add-pallet-to-cart-button', function() {
        if($('.products.show').length) {
          var qunatity_value = $(this).data('palletQuantity');
          var max_value = parseInt($('#quantity.quantity').attr("max"));

          if ( max_value > qunatity_value && $('#quantity.quantity')[0].hasAttribute("max")) {
            $( '.stock-error-message' ).css('display', 'none').html('');
            $('.checkout-add-to-cart-button').show();
            $('#quantity.quantity').val(qunatity_value).prev('.sub-btn').removeClass( 'disable_btn' ).attr( "disabled", false);
          }
          else if ( max_value <= qunatity_value && $('#quantity.quantity')[0].hasAttribute("max")) {
            $('#quantity.quantity').val(qunatity_value).prev('.sub-btn').removeClass( 'disable_btn' ).attr( "disabled", false);
            $('#quantity.quantity').next('.add-btn').addClass( 'disable_btn' ).attr( "disabled", true);
            $('.stock-error-message').css('display', 'block').html('Available Quantity: '+ max_value);
          }
        }
      });

      $(".question-submit-btn").click(function() {
        var form = $("#new_product_question");
        if ( form[0].checkValidity() === false ) {
          event.preventDefault();
          event.stopPropagation();
          $('.body').addClass('validation-error');
          $(this).prop("disabled", true);
          if ( $('#product_question_name').val() == "" ) {
            $('.questioner-name-error').show();
          }
          if ($('#product_question_question').val() == "") {
            $('.question-required-error').show();
          }
        }
        $(this).addClass('disable_btn').removeClass('btn-gradient-orange');
        form.addClass('was-validated')
      });

      $(".review-submit-btn").click(function() {
        var form = $("#new_review");
        if ( $('input.rating').val() == '0' ) {
          $('.body').addClass('validation-error');
          $(this).addClass('disable_btn').removeClass('btn-gradient-orange');
          $(this).prop("disabled", true);
          $('.rating-required-error').css('display', 'block');
        }

        if ( form[0].checkValidity() === false ) {
          event.preventDefault();
          event.stopPropagation();
          $('.body').addClass('validation-error');
          $(this).prop("disabled", true);
          if ( $('#review_name').val() == "" ) {
            $('.review-name-error').show();
          }

          if ( $('#review_title').val() == "" ) {
            $('.review-title-error').show();
          }

          if ( $('#review_review').val() == "" ) {
            $('.review-review-error').show();
          }

          if ($('#review_email').val() == "" ) {
            $('.review-email-error').show();
          }
        }
        $(this).addClass('disable_btn').removeClass('btn-gradient-orange');
        form.addClass('was-validated');
      });

      function removeReviewError() {
        $('.body').removeClass('validation-error');
        $('.review-submit-btn').addClass('btn-gradient-orange').removeClass('disable_btn');
        $('.review-submit-btn').prop("disabled", false);
      }

      $('#review_name').on('input', function ()  {
        $('.review-name-error').hide();
        removeReviewError();
      });

      $('#review_title').on('input', function ()  {
        $('.review-title-error').hide();
        removeReviewError();
      });

      $('#review_review').on('input', function ()  {
        $('.review-review-error').hide();
        removeReviewError();
      });

      $('#review_email').on('input', function () {
        $('.review-email-error').hide();
        removeReviewError();
      })

      $('.rating_star').on('click', function() {
        if($('.review-submit-btn').hasClass('disable_btn')) {
          $('.rating-required-error').css('display', 'none');
          if($('.image-upload-error').css('display') == 'none') {
            removeReviewError();
          }
        }

        for (i = 1 ; i <= this.id.split('')[0]; i++) {
          $('#'+i+'star').next().removeClass('label_star').addClass('selected-label_star');
        }

        for (i > this.id ; i <= 5; i++) {
          $('#'+i+'star').next().removeClass('selected-label_star').addClass('label_star');
        }
      });

      $('#review_images').bind('change', function() {
        if ( document.getElementById("review_images").files.length != 0) {
          $('.image-selected').css('display', 'contents');
          $('.image-upload-error').css('display', 'none');
          $('.image-tag-content').html('Upload Images');
          $('.image-upload').addClass('active-upload').removeClass('default-upload failed-upload');
          if( $('.rating-required-error').css('display') == 'none') {
            removeReviewError();
          }
        }
        else {
          $('.image-selected').css('display', 'none');
          $('.image-upload').addClass('default-upload').removeClass('active-upload');
        }
      });

      $('.card-image-container').mouseover(function(){
        $(this).find('.view-large').css('display', 'block');
      });

      $('.card-image-container').mouseleave(function(){
        $(this).find('.view-large').css('display', 'none')
      });
    }

    if($(document).width() < 992 ) {
      $('.prod-question-section, .v-description-section, .prod-review-section, .prod-no-review-section, .prod-no-question-section').addClass("collapse");
      $('.customer-reviews, .customer-questions').addClass("show active");
    }
    else {
      $('.prod-question-section, .v-description-section, .prod-review-section, .prod-no-review-section, .prod-no-question-section').removeClass("collapse");
    }

    function related_products() {
      const tabSize = 4;
      const cardsGroup = $('.card-pages-group .cards');
      makeTabs();


      $(document).on('click', '.load-btn', function(){
        if ($(this).hasClass('disabled')) return false;
        let product_id = $(this).data('params-id');
        let direction = $(this).hasClass('nav-forward') ? 1 : -1;
        switchTab(direction, $("#"+$(this).data('current-section')),product_id);
      });

      function addplaceholders(n, current_section){
        for (let i = 0; i < n; i++) {
          $(current_section).append(cardPlacholder());
        }
      }

      function cardPlacholder() {
        return `<div class="slider-card" data-tab="" data-loaded="false">
          <div class="product-card-placeholder">
            <div class="image"></div>
            <div class="price"></div>
            <div class="name"></div>
          </div>
        </div>`;
      }

      function makeTabs(){
        cardsGroup.each(function() {
          const totalCards = parseInt(this.dataset['totalCards']);
          addplaceholders( totalCards - tabSize, this);

          $(this).children().each(function(i) {
            this.dataset['tab'] = parseInt(i/tabSize) + 1
          });
        });
      }

      const activeTab = (current_section) => parseInt($(current_section).find($('.slider-card.visible')).data('tab'));

      const switchTab = (n, current_section,product_id) => {
        let current = activeTab(current_section);
        let nextTab = current + n;
        $(current_section).find($(`.slider-card[data-tab="${current}"]`)).removeClass('visible');
        $(current_section).find($(`.slider-card[data-tab="${nextTab}"]`)).addClass('visible');
        enableDisableNavButtons(current_section);
        n > 0 && !($(current_section).find($(`.slider-card[data-tab="${nextTab}"]`)).data('loaded')) && loadProducts(nextTab, current_section,product_id)
      }

      const enableDisableNavButtons = (current_section) => {
        setBackButton(current_section);
        setForwadButton(current_section);
      }

      const setBackButton = (current_section) => {
        let button = $(current_section).prev().find($('.nav-back'));
        activeTab(current_section) > 1 ? button.removeClass('disabled') : button.addClass('disabled');
      }

      const setForwadButton = (current_section) => {
        let button = $(current_section).next().find($('.nav-forward'));
        activeTab(current_section) * 4 < $(current_section).data('totalCards') ? button.removeClass('disabled') : button.addClass('disabled');
      }

      function loadProducts(tab, current_section,product_id) {
        let limit = tabSize
        let offset = (tab - 1) * tabSize
        let id = 'load-tab-' + tab
        const link =`<a id="${id}" href="/${$(current_section).attr('id')}_cards?limit=${limit}&offset=${offset}&tab=${tab}&id=${product_id}" data-remote="true">link</a>`
        $(current_section).append(link)
        $(`#${id}`)[0].click();
        $(`#${id}`).remove();
      }
    };
  }

  $(window).on('load', function () {
    $('.product-card img.image_load').removeClass('image_overlay');

    if (!$('.products.deals').length) {
      $('.product-card .name, .product-card .image-container').mouseover(function() {
        $(this).parent('.product-card').addClass('hoverclass');
      });
      $('.product-card .image-container, .product-card .name').mouseleave(function(){
          $(this).parent('.product-card').removeClass('hoverclass');
      });
    }
    $('.video-overlay').removeClass('video_overlay');
    $('.img-holder').removeClass('image_overlay');
    $('.productlist-image img').removeClass('image_overlay');
    $('.video_loader').removeClass('video_overlay');
    $('.baling_image_l img.image-holder').removeClass('video_overlay');

    if ($('.products.show').length) {
      $('.show-related-products')[0].click();
    }
  });

  if (!event.originalEvent.data.timing.visitStart) {
    $('.product-card img.image_load').addClass('image_overlay');
    $('.video-overlay').addClass('video_overlay');
    $('.img-holder').addClass('image_overlay');
    $('.productlist-image img').addClass('image_overlay');
    $('.video_loader').addClass('video_overlay');
    $('.baling_image_l img.image-holder').addClass('video_overlay');
  }
});


# touched on 2025-05-22T20:37:21.596617Z
# touched on 2025-05-22T23:02:56.658728Z