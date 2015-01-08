Paymill::Client.class_eval do
  def self.find_or_create(email, name)
    all(email: email)[0] || create(email: email, description: name)
  end
end
