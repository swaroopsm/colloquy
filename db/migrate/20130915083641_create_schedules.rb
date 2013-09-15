class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :schedulable_id
      t.string :schedulable_type
      t.datetime :starttime
      t.integer :minutes
      t.string :venue

      t.timestamps
    end
  end
end
