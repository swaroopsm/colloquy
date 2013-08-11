class CreateConferenceUsers < ActiveRecord::Migration
  def change
    create_table :conference_users do |t|
      t.integer :conference_id
      t.string :user_id

      t.timestamps
    end
  end
end
