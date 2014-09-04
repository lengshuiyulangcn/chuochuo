#encoding:utf-8
class PassagesController < ApplicationController
 before_filter :authenticate_user!, :except=>'nologin'
 def index
	 @passages=Passage.where(:user_id=>current_user.id).order("last_translated_at DESC").paginate(:page => params[:page], :per_page => 10)	
 end
 def show
	@passage=Passage.find(params.permit(:id)[:id])
	@users=[]
	@passage.translations.each do |translation|
	 @users << translation.user
	end
	@users.uniq!
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
	unless current_user.point <30
	@passage=Passage.new(passage_params)
	@passage.user_id=current_user.id
	@passage.last_translated_at=Time.now
	if @passage.save
        redirect_to passage_path(@passage.id)
	else
	flash[:error]="不知道为什么出错了"
	redirect_to :back
	end
	else
	flash[:error]="积分不够不能新建翻译。翻译句子可以获取积分哦"
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
	 else
		Taglist.destroy_all(:passage_id=>@passage.id)
	 end
	 redirect_to :back
 end
 def nologin
	if user_signed_in?
	redirect_to  passage_path(params.permit(:id)[:id])
	end	
 	@passage=Passage.find(params.permit(:id)[:id])
	@users=[]
	@passage.translations.each do |translation|
	 @users << translation.user
	end
	@users.uniq!
	@sentences=Sentence.where(:passage_id=>@passage.id).order(:sentence_no)
 end
 private
  def passage_params
  	params.require(:passage).permit(:id,:title,:content,:user_id,:label)
  end
end
