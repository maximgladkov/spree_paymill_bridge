Spree::CreditCard.class_eval do 
	attr_accessor :token
	alias_attribute :paymill_client, :gateway_customer_profile_id
	alias_attribute :paymill_payment, :gateway_payment_profile_id

private

	alias_method :__old_require_card_numbers?, :require_card_numbers?
 	def require_card_numbers?
 		__old_require_card_numbers? && payment_method.require_card_numbers?
 	end

end