Paymill::AuthenticationError.class_eval do
  def to_s
    Spree.t(:unable_to_connect_to_gateway)
  end
end
