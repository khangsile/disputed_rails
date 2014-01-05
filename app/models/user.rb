class User < ActiveRecord::Base
	include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :votes
  has_many :questions, through: :votes
  has_many :created_questions, foreign_key: 'user_id', class_name: 'Question'

  before_save do
   self.email = self.email.downcase
   self.ensure_authentication_token
  end

end
