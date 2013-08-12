class RenamePagetypeToPagecat < ActiveRecord::Migration
  def up
  	 rename_table :pagetypes, :pagecats
  end

  def down
  end
end
