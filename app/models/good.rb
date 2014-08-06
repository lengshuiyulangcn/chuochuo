class Good < ActiveRecord::Base
belongs_to :user
belongs_to :translation
after_create :notify
	def update_translation
		translation.good_count=translation.goods.size
		translation.save
	end

 def notify
	 unless user==self.translation.user
		 content="用户<a href='users/#{user.id}'>#{user.username}</a>觉得你在<a href='/passages/#{translation.passage.id}'>#{translation.passage.title}</a>的翻译很赞。"
		 Notification.create(:user_id=>self.translation.user.id, :content=>content)
	 end
 end
end
