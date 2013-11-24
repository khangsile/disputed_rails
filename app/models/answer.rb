class Answer < ActiveRecord::Base
	belongs_to :question
	has_many :votes

	validate :name, presence: true
	validate :question_id, presence: true
end
