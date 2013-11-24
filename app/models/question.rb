class Question < ActiveRecord::Base
	belongs_to :category
	has_many :answers, dependent: :destroy

	validate :content, presence: true
end
