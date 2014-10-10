Paymill::Base.class_eval do 

	def to_active_merchant_response
		response(true, "#{self.class} Success", {}, {authorization: authorization})
	end

private

	def response(*args)
		ActiveMerchant::Billing::Response.new(*args)
	end

	def authorization
		id
	end

end