#encoding:utf-8
class Passage < ActiveRecord::Base
include ActionView::Helpers::SanitizeHelper	
has_many :translations
	has_many :comments, :dependent => :delete_all
	belongs_to :user
      	has_many :sentences, :dependent => :delete_all
      	has_many :taglists, :dependent => :delete_all
  validates_length_of :content, minimum:10, maximum: 4096, too_short: "should be longer than 10 characters", too_long: "no longer than 4096 characters"
validates_length_of :title, minimum:2, maximum: 255, too_short: "should be longer than 2 characters", too_long: "no longer than 255 characters"
validates :label, :presence => true
after_create :init_pure_html
after_create :make_tags
	def init_sentence
		count=0
		Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>self.title)
		if self.content.language!=:english	
		 	if self.content.scan("\n").size<5

				self.content.split(/。/).each do |sentence|
				count+=1
				Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>sentence+"。") if sentence.chomp!=""
				end
			else
				self.content.split(/\n/).each do |sentence|
				count+=1
				Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>sentence) if sentence.chomp!=""
				end
		
			end
		else
		 Scalpel.cut(self.content).each do |sentence|
		count+=1
		Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>sentence) if sentence.chomp!=""
		end
		end
		user.point-=30;
		user.save
   	end
def init_with_html
		count=0
		Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>self.title)
		doc=Nokogiri::HTML(self.content)
		doc.search('//text()').map(&:text).each do |link|
		count+=1
		Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>link.strip) if link.strip!=""
		
		end
end

def init_pure_html
	count=0
	will_have_trans=1
	Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>self.title)
	self.content.each_line do |line|
	count+=1
	Sentence.create(:passage_id=>self.id,:sentence_no=>count,:content=>line) if line.chomp!=""
	will_have_trans+=1 if strip_tags(line).strip!=""
	end
	self.sencount=will_have_trans
	self.save 
end

	def make_tags
		tags=self.label.split(" ")
		tags.each do  |tag|
			thistag=Tag.where(:content=>tag).first
			if thistag==nil
			thistag=Tag.create(:content=>tag)
			end	
			Taglist.create(:passage_id=>self.id, :tag_id=>thistag.id)
		end	
	end
	def complete_percentage
		total=self.sencount
		translated=0
		self.sentences.each{|sentence| translated+=1 if sentence.translations!=[]}
		return (translated.to_f*100/total).to_i
	end
	def my_tags
		result=[]
		if label!=nil
		self.label.split(" ").each do |tag|
			result << Tag.where(:content=>tag).first
		end
		result.uniq
		else
			return []
		end
	end
	def user_percentage id
		translations=User.find(id).translations&self.translations
		return (translations.size.to_f*100/self.sentences.size).to_i
	end
end
