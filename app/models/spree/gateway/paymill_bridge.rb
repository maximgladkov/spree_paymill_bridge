module Spree
    class Gateway::PaymillBridge < Spree::Gateway
        preference :public_key, :string
        preference :private_key, :string
        
        def provider_class; self.class end
        def method_type; 'paymill' end
    	def payment_profiles_supported?; true end
        def require_card_numbers?; false end

        def authorize(amount, card, options)
            paymill_request do
                Paymill::Preauthorization.create(amount: amount, currency: options[:currency], payment: card.paymill_payment)
            end
        end

        def capture(amount, preauthorization_id, options)
            paymill_request do
                Paymill::Transaction.create(amount: amount, currency: options[:currency], preauthorization: preauthorization_id)
            end
        end

        def purchase(amount, card, options)
            paymill_request do
                Paymill::Transaction.create(amount: amount, currency: options[:currency], payment: card.paymill_payment, client: card.paymill_client)
            end
        end

        def credit(amount, card, transaction_id, opts)
            paymill_request do
                Paymill::Refund.create(amount: amount, id: transaction_id)
            end
        end

        def void(authorization, card, options={})
            paymill_request do
                Paymill::Preauthorization.delete(id: authorization)
            end
        end

        def create_profile(payment)
            card = payment.source
            return if card.has_payment_profile?
            return unless card.token
            
            paymill_request do
                card.paymill_client = find_or_create_client(payment.order.email, card.name).id
                card.paymill_payment = Paymill::Payment.create(token: card.token, client: card.paymill_client).id
                card.save
            end
        end

    private

        def find_or_create_client(email, name)
            Paymill::Client.all(email: email)[0] ||
            Paymill::Client.create(email: email, description: name)
        end

        def paymill_request
            Paymill.api_key = preferred_private_key
            yield.try(:to_active_merchant_response)
        rescue Paymill::PaymillError => error
            gateway_error(error)
        end

        def gateway_error(error)
            logger.error(Spree.t(:gateway_error))
            logger.error("  #{error.to_yaml}")
            raise Core::GatewayError.new(error)  
        end

    end
end