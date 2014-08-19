class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
mount_uploader :icon, IconUploader
validates :username, presence: true
validates :username, uniqueness: true, if: -> { self.username.present? }  
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
has_many :passages
has_many :translations
has_many :notifications
has_many :comments
after_create :init

def init
	self.bio="6cm的壮汉"
	self.icon="../2/Contact.png"
	self.save
end
def my_concern
   		passages=[]
   		Translation.where(:user_id=>self.id).each do |translation|
   			passages << translation.sentence.passage
   		end
   		passages.uniq
   end
   def count_goods
	   	count=0
   		self.translations.each do |translation|
			count+=translation.goods.size
		end
		return count
   end
   def count_notifications
   	Notification.where(:user_id=>self.id, :read=>false).size
   end
end
