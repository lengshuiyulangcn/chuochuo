class TaglistsController < ApplicationController
 def index
 	
 end
 def show_by_tagid
	 @tag=Tag.where(:content=>params.permit[:id])
	 taglists=Taglist.where(:tag_id=>@tag.id)
	@passages=[]
	taglists.each do |taglist|
		@passages << Passage.where(:passage_id=>taglist.passage_id).first
	end
 end
end
