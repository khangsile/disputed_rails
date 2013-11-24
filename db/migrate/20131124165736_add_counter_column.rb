class AddCounterColumn < ActiveRecord::Migration
  def change
  	add_column :questions, :votes_count, :integer
  	add_column :answers, :votes_count, :integer
  	Answer.find_each do |a|
  		a.update(votes_count: a.votes.length)
  	end
  	Question.find_each do |q|
  		q.update(votes_count: q.votes.length)
  	end
  end
end
