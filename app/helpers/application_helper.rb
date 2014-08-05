module ApplicationHelper
	def most_used_tags num
		tag_hash=Hash.new(0)
		Taglist.all.each do |taglist|
			tag=Tag.find(taglist.tag_id)
			tag_hash[tag]+=1
		end
	print	tag_hash.sort.first
		tag_hash.sort{|(a,b),(c,d)| d<=>b}.first num
	end
end
