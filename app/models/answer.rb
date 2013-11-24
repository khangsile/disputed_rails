class Answer < ActiveRecord::Base
	belongs_to :question

	validate :name, presence: true
	validate :question_id, presence: true
end
