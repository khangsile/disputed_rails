class Question < ActiveRecord::Base
	belongs_to :category
	has_many :answers, dependent: :destroy

	has_many :votes
	has_many :users, through: :votes

	validate :content, presence: true
end
