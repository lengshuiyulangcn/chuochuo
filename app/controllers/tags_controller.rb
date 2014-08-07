#encoding:utf-8
class TagsController < ApplicationController
    def new
	    @tag=Tag.new
    end
    def create
	    @tag=Tag.new(params.require(:tag).permit(:content)[:content])
	    unless @tag.save
		  flash[:error]="创建失败"  

	    end
	    redirect_to :back
    end
    def show
	 @tag=Tag.find(params.permit(:id)[:id])
	 taglists=Taglist.where(:tag_id=>@tag.id)
	passage_ids=[]
	taglists.each do |taglist|
		passage_ids << taglist.passage_id
	end
 @passages = Passage.where(:id => passage_ids.uniq).order("last_translated_at DESC").paginate(:page => params[:page], :per_page => 10)

    end
    def delete
    end
end
