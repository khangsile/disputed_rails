class AddSearchVectorToQuestions < ActiveRecord::Migration
  def up
    # 1. Create the search vector column
    add_column :questions, :search_vector, 'tsvector'

    # 2. Create the gin index on the search vector
    execute <<-SQL
      CREATE INDEX questions_search_idx
      ON questions
      USING gin(search_vector);
    SQL

    # 4 (optional). Trigger to update the vector column 
    # when the questions table is updated
    execute <<-SQL
      DROP TRIGGER IF EXISTS questions_search_vector_update
      ON questions;
      CREATE TRIGGER questions_search_vector_update
      BEFORE INSERT OR UPDATE
      ON questions
      FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger (search_vector, 'pg_catalog.english', content);
    SQL

    Question.find_each { |q| q.touch }
  end

  def down
    remove_column :questions, :search_vector
    execute <<-SQL
      DROP TRIGGER IF EXISTS questions_search_vector_update on questions;
    SQL
  end
end
