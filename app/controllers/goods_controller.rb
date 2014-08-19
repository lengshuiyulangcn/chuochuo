class GoodsController < ApplicationController
 before_filter :authenticate_user!
	def think_good
		good=Good.where(:user_id=>current_user.id,:translation_id=>good_params[:id]).first
		if good!=nil
			translation=good.translation
			translation.update(:good_count=>translation.good_count-1)
		 good.user.point-=1 if current_user!=good.user
		 good.user.save
		  Good.delete(good)
		else
			good=Good.new
			good.translation_id=good_params[:id]
			good.user_id=current_user.id
			good.save
			translation=good.translation
			translation.update(:good_count=>translation.good_count+1)
		end
		redirect_to :back
	end
	private
	def good_params
		params.permit(:id)
	end
end
