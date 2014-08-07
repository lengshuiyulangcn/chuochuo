class HomeController < ApplicationController
	 before_filter :authenticate_user!, :except=>:index
	def index
		@passages=Passage.all.order("last_translated_at DESC").paginate(:page => params[:page], :per_page => 10)	
	end
	def show_concern
		@user=User.find(params.permit(:id)[:id])
                passage_ids=[]
                Translation.where(:user_id=>@user.id).each do |translation|
		  passage_ids << translation.passage_id
		end
		   @passages = Passage.where(:id => passage_ids.uniq).order("last_translated_at DESC").paginate(:page => params[:page], :per_page => 10)	
	end
end
