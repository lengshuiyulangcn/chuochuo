class Good < ActiveRecord::Base
belongs_to :user
belongs_to :translation
#after_save :update_translation
	def update_translation
		translation=self.translation
		translation.good_count=translation.goods.size
		translation.save
	end
end
