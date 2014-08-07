#encoding:utf-8
class PassagesController < ApplicationController
 before_filter :authenticate_user!
 def index
	 @passages=Passage.where(:user_id=>current_user.id).order("last_translated_at DESC").paginate(:page => params[:page], :per_page => 10)	
 end
 def show
 	@passage=Passage.find(params.permit(:id)[:id])
	@sentences=Sentence.where(:passage_id=>@passage.id).order(:sentence_no)
 end
 def new
        @passage=Passage.new
 end
 def edit
	 @passage=Passage.find(params.permit(:id)[:id])
	 if @passage.user!=current_user
	 	flash[:error]="不可以修改别人的发帖内容"
		 redirect_to :back
	 end
 end 
 def create
	@passage=Passage.new(passage_params)
	@passage.user_id=current_user.id
	@passage.last_translated_at=Time.now
	if @passage.save
        redirect_to passage_path(@passage.id)
	else
	flash[:error]="不知道为什么出错了"
	redirect_to :back
	end
 end
 def destroy
	 @passage=Passage.find(params.permit(:id)[:id])
	 if @passage.user!=current_user
	 	flash[:error]="不可以删除别人的内容"
		 redirect_to :back
	 end
	 unless Passage.delete(@passage)
	 flash[:error]="不知道为什么出错了"
	 end
	 redirect_to root
 end
 private
  def passage_params
  	params.require(:passage).permit(:id,:title,:content,:user_id,:label)
  end
end
