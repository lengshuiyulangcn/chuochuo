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
	@passages=[]
	taglists.each do |taglist|
		@passages << Passage.find(taglist.passage_id)
	end
    end
    def delete
    end
end
