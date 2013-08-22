class AddColumnToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :day, :integer
  end
end
