Spree::Core::Engine.routes.draw do
	resources :credit_cards, only: :destroy
end
