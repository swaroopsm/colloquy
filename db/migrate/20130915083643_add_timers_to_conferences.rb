class AddTimersToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :early_bird_close, :date
    add_column :conferences, :abstract_submission_start, :date
    add_column :conferences, :abstract_submission_close, :date
    add_column :conferences, :workshop_registration_start, :date
    add_column :conferences, :workshop_registration_close, :date
    add_column :conferences, :online_registration_close, :date
  end
end
