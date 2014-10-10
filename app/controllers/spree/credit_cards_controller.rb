module Spree
	class CreditCardsController < StoreController

		def destroy
			card = CreditCard.find_by_id(params[:id])
			card.user_id = nil
			card.save
			redirect_to account_path
		end

	end
end