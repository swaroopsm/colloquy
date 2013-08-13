class CreateTableWorkshopAttendees < ActiveRecord::Migration
  def up
  	create_table :workshop_attendees do |t|
      t.integer :user_id
      t.integer :workshop_id

      t.timestamps
    end
  end

  def down
  end
end
