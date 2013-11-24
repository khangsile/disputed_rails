class Question < ActiveRecord::Base
	belongs_to :category
	has_many :answers

	validate :content, presence: true
end
