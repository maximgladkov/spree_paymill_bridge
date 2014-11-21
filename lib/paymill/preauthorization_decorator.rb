Paymill::Preauthorization.class_eval do 

private

  def authorization
    preauthorization['id']
  end

end