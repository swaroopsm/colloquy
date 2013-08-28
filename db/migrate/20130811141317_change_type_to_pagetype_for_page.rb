class ChangeTypeToPagetypeForPage < ActiveRecord::Migration
  def up
  	rename_column :pages, :type, :pagetype_id
  end

  def down
  end
end
