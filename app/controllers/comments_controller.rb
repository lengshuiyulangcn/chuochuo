class CommentsController < ApplicationController
 before_filter :authenticate_user!, :except=>"passage_comment"
	def index
	end
	def show
	end
	def passage_comment
		@comment=Comment.new
		@passage=Passage.find(params.permit(:id)[:id])
		@comments=Comment.where(:passage_id=>params.permit(:id)[:id]).order(:flour_id)
	end
	def create
		@comment=Comment.new(comment_params)
		@comment.flour_id=Passage.find(comment_params[:passage_id]).comments.size+1
		@comment.user_id=current_user.id
		if @comment.save
		  flash[:info]="创建成功"
		else
		  flash[:eror]="创建失败"
		end
		redirect_to passageComment_path(comment_params[:passage_id])
	end
	def edit
		@comment=Comment.find(params.permit(:id)[:id])
		if current_user!=@comment.user
			flash[:notice]="不可以编辑别人帖子，还是去抢别人妹子吧"
			redirect_to  :back
		end
	end
	def update
		@comment=Comment.find(params.permit(:id)[:id])
		if current_user!=@comment.user
			flash[:notice]="不可以编辑别人帖子，还是去抢别人妹子吧"
		redirect_to passageComment_path(@comment.passage.id)
		end
		@comment.content=comment_params[:content]
		if @comment.save
			flash[:notice]="更新成功"
		else
			flash[:error]="更新失败，可能是太短了"
		end
		redirect_to passageComment_path(@comment.passage.id)
	end
	private
	def comment_params
		params.require(:comment).permit(:content,:user_id,:passage_id)
	end
end
