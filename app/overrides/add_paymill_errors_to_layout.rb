Deface::Override.new({
  virtual_path: 'spree/layouts/spree_application', 
  name: 'add_pamill_errors_to_frontend',
  insert_bottom: 'body', 
  partial: 'spree/shared/paymill_errors'
})

Deface::Override.new({
  virtual_path: 'spree/layouts/admin', 
  name: 'add_pamill_errors_to_backend',
  insert_bottom: 'body', 
  partial: 'spree/shared/paymill_errors'
})