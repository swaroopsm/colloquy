class RenameTypeToTitleInPagecat < ActiveRecord::Migration
  def up
  	rename_column :pagecats, :type, :title
  end

  def down
  end
end
