class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :user_id, index: true
    	t.integer :question_id, index: true
    	t.integer :answer_id, index: true
      t.timestamps
    end
  end
end
