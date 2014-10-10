Paymill::AuthenticationError.class_eval do 

	def message
		Spree.t(:unable_to_connect_to_gateway)
	end

end