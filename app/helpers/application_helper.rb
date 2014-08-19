module ApplicationHelper
	def most_used_tags num
		tag_hash=Hash.new(0)
		Taglist.all.each do |taglist|
			tag=Tag.find(taglist.tag_id)
			tag_hash[tag]+=1
		end
		tag_hash.sort{|(a,b),(c,d)| d<=>b}.first num
	end

	def bootstrap_class_for flash_type
    { :success=>"alert-success", :error=>"alert-danger", :alert=>"alert-warning", :notice=> "alert-info" }[flash_type] || flash_type.to_s
  end
 
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
end
