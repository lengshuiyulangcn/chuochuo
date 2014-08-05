#encoding:utf-8
class Passage < ActiveRecord::Base
 has_many :sentences
  validates_length_of :content, minimum:10, maximum: 4096, too_short: "should be longer than 10 characters", too_long: "no longer than 4096 characters"
validates_length_of :title, minimum:2, maximum: 255, too_short: "should be longer than 2 characters", too_long: "no longer than 255 characters"
after_create :init_sentence

	def init_sentence
		count=0
		self.content.split("。").each do |sentence|
		count+=1
		Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>sentence+"。")
		end
   	end
end
