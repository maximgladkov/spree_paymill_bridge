Spree::CreditCard.class_eval do 
  attr_accessor :token
  alias_attribute :paymill_client, :gateway_customer_profile_id
  alias_attribute :paymill_payment, :gateway_payment_profile_id

private

  alias_method :__old_require_card_numbers?, :require_card_numbers?
  def require_card_numbers?
    return false unless __old_require_card_numbers?
    return true unless payment_method
    return true unless payment_method.respond_to?(:require_card_numbers?)
    payment_method.require_card_numbers?
  end

end