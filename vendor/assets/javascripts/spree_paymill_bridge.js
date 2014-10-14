var PAYMILL_PUBLIC_KEY = '';

var SpreePaymillBridge = {

	init: function(){
		this.checkout_form().submit(function(event){
			event.preventDefault();
			SpreePaymillBridge.submit();
		});
	},

	submit: function(){
		this.id = this.payment_method();

		if(this.is_paymill()){
			var that = this;
			this.clear_errors();
			PAYMILL_PUBLIC_KEY = this.public_key();

			var card = {
				cardholder: this.cardholder(),
				number:     this.number(),
				exp_month:  this.exp_month(),
				exp_year:   this.exp_year(),
				cvc:        this.cvc(),
				amount_int: this.amount_int(),
				currency:   this.currency()
			};

			var errors = this.validate(card);
			if(errors){ this.process_errors(errors); return; }
			
			paymill.createToken(card, function(error, result){
				if(error){ that.process_errors(error); return; }
				
				that.set_token(result["token"]);
				that.set_brand(result["brand"]);
				that.set_last_digits(result["last4Digits"]);
				that.checkout_form().get(0).submit();
			});	
			
		} else {
			this.checkout_form().get(0).submit();
		}
	},

	checkout_form:   function(){},
	payment_method:  function(){ return $('input[name*=payment_method_id]:checked').val(); },
	public_key:  	 function(){ return $('#public-key-'    + this.id).val(); },
	is_paymill:      function(){ return $('#is-paymill-'    + this.id).val(); },
	cardholder:      function(){ return $('#holdername-'    + this.id).val(); },
	number:          function(){ return $('#card-number-'   + this.id).val(); },
	exp_month:       function(){ return $('#exp-month-'     + this.id).val(); },
	exp_year:        function(){ return $('#exp-year-'      + this.id).val(); },
	cvc:             function(){ return $('#card-cvc-'      + this.id).val(); },
	currency:        function(){ return $('#card-currency-' + this.id).val(); },
	amount_int:      function(){},
	set_token:       function(new_value){ $('#token-'       + this.id).val(new_value); },
	set_brand:       function(new_value){ $('#brand-'       + this.id).val(new_value); },
	set_last_digits: function(new_value){ $('#last-digits-' + this.id).val(new_value); },
	put_errors: 	 function(){},
	clear_errors:    function(){ $('#errorExplanation').remove(); },
	enable_button:   function(){ $('.continue.button').attr('disabled', false); },

	validate: function(card){
		errors = {
			number: !paymill.validateCardNumber(card.number),
			expiry: !paymill.validateExpiry(card.exp_month, card.exp_year),
			cvc: 	!paymill.validateCvc(card.cvc)
		};
		return errors.number || errors.expiry || errors.cvc ? errors : false;
	},

	process_errors: function(errors){
		this.enable_button();
		this.display_errors(errors);
	},

	error_count: function(errors){
		return (errors.number|0) + (errors.expiry|0) + (errors.cvc|0) + !!(errors.apierror);
	},

	display_errors: function(errors){
		var s = '';

		s += '<div id="errorExplanation" class="errorExplanation">';
		s += '<h2>There are ' + this.error_count(errors) + ' errors that prohibited this record from being saved.</h2>';
		s += '<p>There were promblems with the following fields:</p>';
		s += '<ul>';
		if(errors.number)   s += '<li>Card number is not valid.</li>';
		if(errors.expiry)   s += '<li>Expiry date is not valid.</li>';
		if(errors.cvc) 	    s += '<li>Card code is not valid.</li>';
		if(errors.apierror) s += '<li>' + this.paymill_errors[errors.apierror] + '.</li>';
		s += '</ul>';
		s += '</div>';

		this.put_errors().prepend(s);		
	}

};
