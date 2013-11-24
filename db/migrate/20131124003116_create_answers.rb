class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.string :name
    	t.integer :question_id, index: true
      t.timestamps
    end
  end
end
