class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :name, limit: 24
      t.timestamps
    end
  end
end
