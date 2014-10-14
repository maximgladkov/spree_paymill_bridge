Paymill::APIError.class_eval do

	def initialize(msg=nil)
		super(parse_message(msg))
	end

private

	def parse_message(msg)
		return Spree.t(:gateway_error) unless msg
		return msg unless msg.is_a?(Hash)
		"#{field(msg)}: #{messages(msg)}"
	end

	def field(msg)
		msg['field'].titleize
	end

	def messages(msg)
		msg['messages'].values.join(', ')
	end

end