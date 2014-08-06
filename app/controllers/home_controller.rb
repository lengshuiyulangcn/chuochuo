class HomeController < ApplicationController
	 before_filter :authenticate_user!
	def index
		@passages=Passage.all.order("last_translated_at DESC")		
	end
	def show_concern
		@user=User.find(params.permit(:id)[:id])
                @passages=[]
                Translation.where(:user_id=>@user.id).each do |translation|
		  @passages << translation.sentence.passage
		end
		@passages.uniq!
	end
end
