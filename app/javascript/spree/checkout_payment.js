$(document).on('turbolinks:load', function(event) {
  Checkout_Payment = function() {
    if( $('.checkout.update, .checkout.edit, .checkout.edit_v0').length && $('#store-credit-request-input').length) {
      var orderTotalElement;
      var storeCreditPrice;
      var orderTotal;
      var userTotalAvailableStoreCredit;

      $(document).on('input','#store-credit-request-input ', {} ,function() {
        orderTotalElement = $('.price.total_price');
        storeCreditPrice = $('.price.store_credit_price');
        orderTotal = orderTotalElement.data('orderTotal');
        userTotalAvailableStoreCredit = parseFloat($('#user-total-available-store-credit').data('creditAmount'));

        $('#store-credit-checkbox').prop("checked", ($(this).val() != '') ? true : false);
        applyRequestedStoreCredit();
        applyValidation();
      });

      $('#store-credit-request-input').focusout(function() {
        $(this).css('border-color', '#DADADA')
      });

      new Cleave('#store-credit-request-input', {
        numeral: true,
        prefix: '$',
        rawValueTrimPrefix: true,
        numeralThousandsGroupStyle: 'none',
        numeralDecimalScale: 2
      });

      $('.payment_step_submit_button').on('click', function(){

        var inputField = $('#store-credit-request-input');
        var numaricValue = parseFloat(inputField.val().replace('$',''));
        inputField.val(numaricValue);
      });

      $('#full-check-box-radio').on('input', function(){
        updateAppliedStoreCredit(userTotalAvailableStoreCredit < orderTotal? userTotalAvailableStoreCredit : orderTotal);
      });

      $('#custom-check-box-radio').on('input', function() {
        applyRequestedStoreCredit();
      });

      function applyRequestedStoreCredit() {
        const requestedCredit = parseFloat($('#store-credit-request-input').val().replace('$','0')).toFixed(2);
        var applicableCredit = (requestedCredit > 0 && requestedCredit < orderTotal)? requestedCredit : (requestedCredit >= orderTotal)? orderTotal : 0.0;

        updateAppliedStoreCredit(userTotalAvailableStoreCredit < applicableCredit ? userTotalAvailableStoreCredit : applicableCredit);
      }

      function updateAppliedStoreCredit(amountCredit) {
        const totalAfterCredit =  (orderTotal - amountCredit).toFixed(2);

        const moneyDecimalValue = totalAfterCredit.toString().split('.')[1];
        const moneyWholeValue   = totalAfterCredit.toString().split('.')[0];
        const creditPriceWholeValue   = amountCredit > 0 ? amountCredit.toString().split('.')[0] : '0' ;
        const creditPriceDecimalValue = amountCredit > 0 ? amountCredit.toString().split('.')[1] : '00' ;

        storeCreditPrice.children('.money-whole').html(creditPriceWholeValue);
        storeCreditPrice.children('.money-decimal').html(creditPriceDecimalValue);

        orderTotalElement.children('.money-whole').html(moneyWholeValue);
        orderTotalElement.children('.money-decimal').html(moneyDecimalValue);

        $('#total-order-total').children('.money-whole').html(moneyWholeValue);
        $('#total-order-total').children('.money-decimal').html(moneyDecimalValue);
      }

      function applyValidation() {
        var availableAmount = parseFloat($('#user-total-available-store-credit').data().creditAmount)
        var requestedAmount = parseFloat($('#store-credit-request-input').val().replace('$','0'))
        if (availableAmount < requestedAmount) {
          $('#store-credit-request-input').css('border-color', '#F63939');
          $('.store-error').css('display', 'block');
        }
        else {
          $('#store-credit-request-input').css('border-color', '#1E1E1E');
          $('.store-error').css('display', 'none');
          $('.store-credit-section').css('display','flex');
        }
      }
    }
  }
  Checkout_Payment();
});

# touched on 2025-05-22T22:38:51.645273Z
# touched on 2025-05-22T22:59:55.016554Z
# touched on 2025-05-22T23:48:32.927100Z