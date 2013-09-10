class RemoveColumnDayFroPeriods < ActiveRecord::Migration
  def up
  	remove_column :periods, :day
  end

  def down
  	add_column :periods, :day, :integer
  end
end
