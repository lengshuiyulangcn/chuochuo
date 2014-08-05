class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
validates :username, presence: true
validates :username, uniqueness: true, if: -> { self.username.present? }  
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
has_many :passages
has_many :translations

   def my_concern
   		passages=[]
   		Translation.where(:user_id=>self.id).each do |translation|
   			passages << translation.sentence.passage
   		end
   		passages.uniq
   end
end
