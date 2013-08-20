class ChangeColumnStarttimeInSchedules < ActiveRecord::Migration
  def up
    change_column :schedules, :starttime, :time
  end

  def down
  end
end
