class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string :content, limit: 255
    	t.integer :category_id, index: true
      t.timestamps
    end
  end
end
