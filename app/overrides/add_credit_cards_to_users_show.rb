Deface::Override.new({
	virtual_path: 'spree/users/show', 
	name: 'add_credit_cards_to_users_show',
	insert_after: '[data-hook="account_my_orders"]', 
	partial: 'spree/users/show/credit_cards'
})