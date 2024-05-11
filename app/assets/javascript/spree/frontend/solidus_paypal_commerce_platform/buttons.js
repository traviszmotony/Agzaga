SolidusPaypalCommercePlatform.renderButton = function(payment_method_id, style) {
  paypal.Buttons({
    style: style,
    createOrder: SolidusPaypalCommercePlatform.sendOrder.bind(null, payment_method_id),
    onClick: function(data) {
      $('#use_existing_card_yes').prop('checked', false);
      $('#use_existing_card_no').prop('checked', true);
      $("input[name='save_card']").val(0);
      $("input[name='order[wallet_payment_source_id]']:checked").prop('checked', false);
      $("input[name='order[payments_attributes][][payment_method_id]']").val($('#payment-method-paypal').data('paypal-id'));
      SolidusPaypalCommercePlatform.fundingSource = data.fundingSource
    },
    onCancel: function(data) {
      $('#use_existing_card_yes').prop('checked', true);
      $('#use_existing_card_no').prop('checked', false);
      $("input[name='save_card']").val(1);

      $("input[name='order[wallet_payment_source_id]']").last().click();
      $("input[name='order[payments_attributes][][payment_method_id]']").val($('#payment-method-stripe').data('stripe-id'));
    },
    onApprove: function(data, actions) {
      $("#paypal-loder").addClass('show-checkout-loader');
      SolidusPaypalCommercePlatform.approveOrder(data, actions);
    },
    onShippingChange: SolidusPaypalCommercePlatform.shippingChange,
    onError: SolidusPaypalCommercePlatform.handleError
  }).render('#paypal-button-container')
}

SolidusPaypalCommercePlatform.renderCartButton = function(payment_method_id, style) {
  paypal.Buttons({
    style: style,
    createOrder: SolidusPaypalCommercePlatform.sendOrder.bind(null, payment_method_id),
    onClick: (data) => { SolidusPaypalCommercePlatform.fundingSource = data.fundingSource },
    onApprove: SolidusPaypalCommercePlatform.finalizeOrder.bind(null, payment_method_id),
    onShippingChange: SolidusPaypalCommercePlatform.shippingChange,
    onError: SolidusPaypalCommercePlatform.handleError
  }).render('#paypal-button-container')
}

SolidusPaypalCommercePlatform.renderProductButton = function(payment_method_id, style) {
  paypal.Buttons({
    style: style,
    createOrder: SolidusPaypalCommercePlatform.createAndSendOrder.bind(null, payment_method_id),
    onClick: (data) => { SolidusPaypalCommercePlatform.fundingSource = data.fundingSource },
    onApprove: SolidusPaypalCommercePlatform.finalizeOrder.bind(null, payment_method_id),
    onShippingChange: SolidusPaypalCommercePlatform.shippingChange,
    onError: SolidusPaypalCommercePlatform.handleError
  }).render('#paypal-button-container')
}

SolidusPaypalCommercePlatform.renderVenmoStandalone = function(payment_method_id, style) {
  paypal.Buttons({
    style: style,
    fundingSource: paypal.FUNDING.VENMO,
    createOrder: SolidusPaypalCommercePlatform.sendOrder.bind(null, payment_method_id),
    onClick: () => {
      debugger;
      return SolidusPaypalCommercePlatform.fundingSource = paypal.FUNDING.VENMO
    },
    onApprove: SolidusPaypalCommercePlatform.approveOrder,
    onError: SolidusPaypalCommercePlatform.handleError
  }).render('#paypal-button-container')
}

# touched on 2025-05-22T19:17:34.163046Z
# touched on 2025-05-22T21:51:20.677952Z
# touched on 2025-05-22T23:42:49.048454Z