class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :description
      t.integer :conference_id
      t.integer :user_id

      t.timestamps
    end
  end
end
