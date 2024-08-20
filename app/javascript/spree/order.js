$(document).on('turbolinks:load', function() {
    $(document).on('click', '.btn-empty-cart', function(){
      document.getElementById( "empty_cart" ).submit();
    });

    $('.line_item_quantity' ).on( 'keypress', function(e) {
      var qunatity_value = parseInt($( this ).val());
      var max_value = parseInt($( this ).attr("max"));

      if ( e.keyCode == 13) {
        if (max_value > qunatity_value) {
          document.getElementById('update-cart').submit();
        }
        e.preventDefault();
       }
    });

    $('.input-coupon-code' ).on( 'keypress', function(e) {
      if ( e.keyCode == 13 ) {
        $('input[name="coupon_code"]').val( $('.input-coupon-code').val() );
        document.getElementById('couponcode').submit();
        e.preventDefault();
      }
    });

    $('.input-coupon-code' ).on( 'input', function(e) {
      if($(this).val() != '') {
        $('.coupon_message').css('display', 'none');
      }
    });

    if ( $('#order_ship_address_attributes_phone').length > 0 ) {
      new Cleave( $('#order_ship_address_attributes_phone' ), {
        numericOnly: true,
        delimiters: ["(", ")", " ", "-"],
        blocks: [0, 3, 0, 3, 4]
      });
     }

    if ( $( '#order_bill_address_attributes_phone').length > 0 ) {
      new Cleave( $( '#order_bill_address_attributes_phone' ), {
        numericOnly: true,
        delimiters: ["(", ")", " ", "-"],
        blocks: [0, 3, 0, 3, 4]
      });
     }

    $( '.view-order-summary' ).on( 'click', function() {
      $( "#view-orders" ).toggle();
    });

   $( '.input-coupon-code' ).change( function(event) {
      if( $( '.input-coupon-code' ).val().length > 0 ) {
        $( this ).addClass( 'normal' );
      }
      else {
        $( this ).removeClass( 'normal' );
      }
    });

   if ( $('.checkout.edit, .checkout.update').length ) {
     $('#use_existing_card_no').on('click', function() {
        $('.existing-credit-card-list').addClass('hide-existing-cards');
     });

      $('#use_existing_card_yes').on('click', function() {
        $('.existing-credit-card-list').removeClass('hide-existing-cards');
      });
    }

    $(document).on('change', '#promo-checkbox', function() {
      if(this.checked) {
        $("#promo-code").show();
      }
      else {
        $("#promo-code").hide();
      }
    })

  if( $('.orders.edit').length ) {
    $( '#submit-coupon_code' ).on( 'click', function(event) {
      $( 'input[name="coupon_code"]' ).val( $( '.input-coupon-code' ).val() );
      document.getElementById( "couponcode" ).submit();
    });
  }
});

$(document).ready(function() {
  $(document).on('ajax:beforeSend', '.btn-sub', function() {
    var max_value = parseInt( $(this).next('.product-quantity').attr("max"));
    $( this ).next('.product-quantity ')[0].value = parseInt( $(this).next( '.product-quantity ' ).val() ) - 1;
    var qunatity_value = parseInt( $(this).next('.product-quantity').val());
    if (qunatity_value < 1) {
      $( this ).next('.product-quantity ')[0].value = parseInt( $(this).next( '.product-quantity ' ).val() ) + 1;
      $( this ).addClass("disable_sub")
      return false;
    }
    if ( max_value >= qunatity_value || !max_value) {
      $( this ).addClass( "disable" );
      remove_stock_errors(this);
    }
    else if(max_value) {
      event.preventDefault();
      asign_stock_errors(this, max_value);
    }
  });

  $(document).on('ajax:beforeSend', '.btn-add', function(e) {
    var qunatity_value = parseInt( $(this).prev('.product-quantity').val());
    var max_value = parseInt( $(this).prev('.product-quantity').attr("max"));

    if ( max_value > qunatity_value || !max_value ) {
      $( this ).prev('.product-quantity ')[0].value = qunatity_value + 1;
      $( this ).addClass("disable");
      remove_stock_errors(this);
    }
    else if(max_value) {
      event.preventDefault();
      asign_stock_errors(this, max_value);
        return false;
    }
  });

  $(document).on('ajax:beforeSend', '.product-quantity', function(){
    var max_value = parseInt($( this ).attr("max"));

    if ( !$(this)[0].classList.contains('custom-hose-quantity') || $('.orders.edit').length == 0)
    {
      $( this ).prev('.btn-sub').removeClass( 'disable_btn' ).attr( "disabled", false);
      $( this ).next('.btn-add').removeClass( 'disable_btn' ).attr( "disabled", false);
    }

    if($( this ).val() > max_value && $( this ).val() != '') {
      asign_stock_errors(this, max_value);
      event.preventDefault();
    }
    else {
      remove_stock_errors(this);
    }
  });

  function asign_stock_errors(ele, max_value){
    if($('.orders.edit').length || $('#slider-adc-form').length)
    {
      $( ele ).parents('.cart-product-section').find('.stock-error-message').css('display', 'block').html('Available Quantity: '+ max_value);
    }
    else
    {
      $( ele ).parent().next('.stock-error-message').css('display', 'block').html('Available Quantity: '+ max_value);
    }
  }

  function remove_stock_errors(ele){
    if($('.orders.edit').length)
    {
      $( ele ).parents('.cart-product-section').find('.stock-error-message').css('display', 'none').html('');
    }
    else
    {
      $( ele ).parent().next('.stock-error-message').css('display', 'none').html('');
    }
  }
});

# touched on 2025-05-22T22:32:27.283425Z
# touched on 2025-05-22T23:47:04.455290Z