class AddIndexToTicketInConferenceUsers < ActiveRecord::Migration
  def change
    add_index :conference_users, :ticket, :unique => true
  end
end
