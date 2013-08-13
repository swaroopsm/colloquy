class AddColumnsToWorkshopAttendees < ActiveRecord::Migration
  def change
    add_column :workshop_attendees, :user_id, :integer
    add_column :workshop_attendees, :workshop_id, :integer
  end
end
