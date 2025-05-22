$(document).on('turbolinks:load', function(event) {
  if( $('.checkout.edit').length ) {
    $(document).on('click','#use_existing_card_yes', {} ,function(){
      $("#payment-method-fields").hide();
      $("#payment-methods").hide();
      $(".existing-cc-radio").prop("disabled", false);
    });

    $(document).on('click','#existing-cc-radio', {} ,function() {
      $('.expire-card-group').each(function(index) {
        $('.expire-card-group')[index].children[0].classList.add("grey-panel");
        $('.expire-card-group')[index].children[0].classList.remove("black-panel");
      });

      $(this).parent().parent().removeClass('grey-panel').addClass('black-panel');
    });

    $(document).on('click','#new_card', {} ,function() {
      Spree.onPayment();
      $('.save-my-card').show();
      $('#use_existing_card_no').click();
      $('#existing_cards').hide();
      $(this).hide();
      $('.submit_payment_step').hide();
      $("#payment-method-fields").show();
      $("#payment-methods").removeClass('d-none').addClass('d-block');
      $(".existing-cc-radio").prop("disabled", true);
    });

    $(document).on('click', '.existing-card-option', function() {
      $('.save-my-card').hide();
      $('#existing_cards').show();
      $("#payment-methods").addClass('d-none').removeClass('d-block');
      $('#new_card').show();
      $(".existing-cc-radio").prop("disabled", false);
      $('#payment_step_submit_button').prop("disabled", false).removeClass('disable-save-btn');
    });

    $(document).on('click','.save-btn-payment ', {} ,function() {
      $('#use_existing_card_yes').click();
    });
  }
});

# touched on 2025-05-22T23:25:23.373357Z
# touched on 2025-05-22T23:45:30.668511Z