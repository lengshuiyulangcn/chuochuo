#encoding:utf-8
class TranslationsController < ApplicationController
 before_filter :authenticate_user!
	def create
	   @translation=Translation.new(translation_params)
	   @translation.user_id=current_user.id
	    if @translation.save
	    		
	    else
	    	flash[:error]="内容不能为空"
	    end
	    	redirect_to :back

	end
	def edit
	    @translation=Translation.find(params.permit(:id)[:id])
	end
	def update
	    @translation=Translation.find(translation_params[:id])
	    @translation.content=translation_params[:content]
	    if @translation.save
	    	redirect_to :back
	    end
	end
	def destroy
	    @translation=Translation.find(params.permit(:id)[:id])
	    Translation.delete(@translation)
	    	redirect_to :back
        end

	private
	def translation_params
		params.require(:translation).permit(:id,:sentence_id,:user_id,:content,:passage_id)
	end
end
