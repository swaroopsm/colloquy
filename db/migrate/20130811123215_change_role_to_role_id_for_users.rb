class ChangeRoleToRoleIdForUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :role, :role_id
  end

  def down
  end
end
