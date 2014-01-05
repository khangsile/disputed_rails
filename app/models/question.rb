class Question < ActiveRecord::Base
	belongs_to :category
	has_many :answers, dependent: :destroy

	has_many :votes
	has_many :users, through: :votes
	belongs_to :user

	validate :content, presence: true

	scope :ordered_by_trend, -> { order("hot(votes_count, 0, created_at) DESC") }

	def map_display
		temp_map = Vote.joins(:user).where(question_id: self.id).count(group: [:answer_id,"users.state"])
		map = Hash.new
		temp_map.each do |k,v|
			if map.has_key? k[1]
				map[k[1]][k[0]] = v
			else
				map[k[1]] = {k[0] => v}
			end
		end
		return map
	end

end
