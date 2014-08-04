class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
validates :username, presence: true
validates :username, uniqueness: true, if: -> { self.username.present? }  
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
