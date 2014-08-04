class PassagesController < ApplicationController
 before_filter :authenticate_user!
 def index
 	@passages=Passage.all
 end
 def show
 	@passage=Passage.find(params.permit(:id)[:id])
	@sentences=Sentence.where(:passage_id=>@passage.id).order(:sentence_no)
 end
 def new
        @passage=Passage.new
 end
 
 def create
	@passage=Passage.new(passage_params)
	@passage.user_id=current_user.id
	if @passage.save
        redirect_to passage_path(@passage.id)
	else
	redirect_to passage_path 1
	end
 end

 private
  def passage_params
  	params.require(:passage).permit(:id,:title,:content,:user_id)
  end
end
