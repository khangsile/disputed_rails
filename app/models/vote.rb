class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :question, counter_cache: :votes_count
	belongs_to :answer, counter_cache: :votes_count

	validates_uniqueness_of :question_id, scope: :user_id

end
