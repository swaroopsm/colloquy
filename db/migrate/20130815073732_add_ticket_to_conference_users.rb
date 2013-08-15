class AddTicketToConferenceUsers < ActiveRecord::Migration
  def change
    add_column :conference_users, :ticket, :string
  end
end
