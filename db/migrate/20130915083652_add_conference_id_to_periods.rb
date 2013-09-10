class AddConferenceIdToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :conference_id, :integer
  end
end
