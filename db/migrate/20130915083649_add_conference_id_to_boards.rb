class AddConferenceIdToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :conference_id, :integer
  end
end
