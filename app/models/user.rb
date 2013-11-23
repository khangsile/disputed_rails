class User < ActiveRecord::Base
	include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save do
   self.email = self.email.downcase
   self.ensure_authentication_token
  end
  
end
