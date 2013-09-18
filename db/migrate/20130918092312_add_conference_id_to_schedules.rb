class AddConferenceIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :conference_id, :integer
    add_index	 :schedules, :conference_id
  end
end
