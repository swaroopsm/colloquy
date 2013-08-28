class CreateWorkshopAttendees < ActiveRecord::Migration
  def change
    create_table :workshop_attendees do |t|

      t.timestamps
    end
  end
end
