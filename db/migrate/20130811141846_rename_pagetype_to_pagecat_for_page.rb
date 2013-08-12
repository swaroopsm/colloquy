class RenamePagetypeToPagecatForPage < ActiveRecord::Migration
  def up
  	rename_column :pages, :pagetype_id, :pagecat_id
  end

  def down
  end
end
