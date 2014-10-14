//= require paymill_bridge
//= require spree_paymill_bridge

$.extend(SpreePaymillBridge, {
	checkout_form: function(){ return $('#new_payment'); },
	put_errors:    function(){ return this.checkout_form(); },

	amount_int: function(){ 
		var amount = $('#payment_amount').val(); 
		return parseInt(parseFloat(amount, 10) * 100);
	}

});

$(document).ready(function(){ 
	SpreePaymillBridge.init(); 
});
