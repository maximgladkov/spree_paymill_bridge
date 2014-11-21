//= require paymill_bridge
//= require spree_paymill_bridge

$.extend(SpreePaymillBridge, {
  checkout_form: function(){ return $('#checkout_form_payment'); },
  amount_int:    function(){ return $('#amount-int-' + this.id).val(); },
  put_errors:    function(){ return $('#checkout'); }
});

$(document).ready(function(){ 
  SpreePaymillBridge.init(); 
});
