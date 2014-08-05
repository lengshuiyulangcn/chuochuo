class Sentence < ActiveRecord::Base
belongs_to :passage
has_many :translations

	def get_translators
		result=[]
		self.translations.each do |translation|
			result << translation.user_id
		end
		result
	end
	def get_best_translations number
		self.translations.order("good_count DESC").limit number	
	end
end
