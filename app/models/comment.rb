class Comment < ActiveRecord::Base
belongs_to :user
belongs_to :passage
validates_length_of :content, minimum:8, maximum: 4096, too_short: "太短了，至少比你j8长呀", too_long: "太长了人家受不了"
after_create :send_notifications

private
def parse_at
	        result=[]
		        users=self.content.scan(/@([\S]*)/)
			        users.each{|name|
					        user=User.where(username: name[0])
						        result << user.first.id if user!=[]
							        }
				result << self.passage.user.id
				result.compact.uniq
end

  def send_notifications
	      parse_at.each do |uid|
		            #Notification.create(user_id: uid, comment_id: self.id) unless uid == self.user_id
		              unless uid==self.user_id
		              notification=Notification.new
		              notification.user_id=uid
			      notification.content="用户<a href='/chuochuo/users/#{user_id}'>#{user.username}</a>在<a href='/chuochuo/comment/#{passage.id}'>#{passage.title}的讨论楼</a>中的#{self.flour_id}楼提到你"
		              notification.save
		              end
		         end
  end
		      
end
