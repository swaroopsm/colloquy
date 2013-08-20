class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :conference_id

      t.timestamps
    end
  end
end
