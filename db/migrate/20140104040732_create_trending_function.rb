class CreateTrendingFunction < ActiveRecord::Migration
  def up
  	execute "create or replace function hot(ups integer, downs integer, date timestamp with time zone) 
  	returns numeric as $$ select round(cast(log(greatest(abs($1 - $2), 1)) + sign($1 - $2) * (date_part('epoch', $3) - 1134028003) / 45000.0 as numeric), 7) $$ language sql immutable;"
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
