class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :description
      t.integer :user_id
      t.integer :board_id

      t.timestamps
    end
  end
end
