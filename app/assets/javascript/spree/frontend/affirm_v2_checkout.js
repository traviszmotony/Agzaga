(function(){
  /* wait for the DOM to be ready */
  affirm.ui.ready(function(){
    $(function() {
      /*****************************************************\
          setup loading and cancel events for the form
      \*****************************************************/
      affirm.checkout.on("cancel", function(){
        $("#checkout_form_payment input.disabled")
          .attr("disabled", false)
          .removeClass("disabled");
      });

      var button_text = $("#checkout_form_payment input[type='submit']").val();

      $("#checkout_form_payment input[type='submit']").on("loading", function(){
        button_text = $(this).val();
        $(this).val("Loading...");
      })

      .on("done_loading", function(){
        $(this).val(button_text);
      });

      /*****************************************************\
          handle continue button clicks with .open()
      \*****************************************************/
      // $(document).on('click', '#checkout_form_payment', function(e){
      //   debugger
      //   var checkedPaymentMethod = $('#payment-method-fields input[type="radio"]:checked').val();
      //   var affirmPaymentMethodId = $("#affirm_checkout_payload").data("paymentgateway")
      //   if (affirmPaymentMethodId.toString() === checkedPaymentMethod) {
      //     var $submit_button = $(this).find("input[type='submit']");

      //     /*****************************************************\
      //         set the shared checkout data
      //     \*****************************************************/
      //     affirm.checkout($("#affirm_checkout_payload").data("affirm"));

      //     // show the loading message
      //     $submit_button.trigger("loading");

      //     // submit the checkout
      //     affirm.checkout.post();

      //     e.preventDefault();
      //     return false;
      //   }
      // });
    });
  });
}());

# touched on 2025-05-22T20:35:29.995082Z
# touched on 2025-05-22T23:18:36.129882Z
# touched on 2025-05-22T23:26:59.671291Z