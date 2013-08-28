class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :submission_id
      t.integer :user_id
      t.integer :conservation
      t.integer :science
      t.integer :recommendation

      t.timestamps
    end
  end
end
