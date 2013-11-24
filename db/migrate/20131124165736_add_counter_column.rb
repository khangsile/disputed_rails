class AddCounterColumn < ActiveRecord::Migration
  def self.up
  	add_column :questions, :votes_count, :integer, default: 0
  	add_column :answers, :votes_count, :integer, default: 0
  	Answer.find_each do |a|
  		a.update(votes_count: a.votes.length)
  	end
  	Question.find_each do |q|
  		q.update(votes_count: q.votes.length)
  	end
  end

  def self.down
  	remove_column :questions, :votes_count
  	remove_column :answers, :votes_count
  end
end
