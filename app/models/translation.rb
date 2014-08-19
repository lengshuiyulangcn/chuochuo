class Translation < ActiveRecord::Base
belongs_to :user
belongs_to :sentence
belongs_to :passage
has_many :goods
validates_length_of :content, minimum:1, maximum: 4096, too_short: "should not be null", too_long: "no longer than 4096 characters"
after_create :updatedate
after_create :notify
def count_good
    self.goods.size
 end
 
 def updatedate
 	passage=self.passage
	passage.last_translated_at=Time.now
	passage.save
 end
 def notify
	 unless user==self.passage.user
		 content="用户<a href='/chuochuo/users/#{user.id}'>#{user.username}</a>翻译了你的投稿<a href='/chuochuo/passages/#{passage.id}'>#{passage.title}</a>"
		 Notification.create(:user_id=>self.passage.user.id, :content=>content)
	 end
	user.point+=1
	user.save
 end

end
