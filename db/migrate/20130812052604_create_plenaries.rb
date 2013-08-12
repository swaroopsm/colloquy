class CreatePlenaries < ActiveRecord::Migration
  def change
    create_table :plenaries do |t|
      t.string :title
      t.text :content
      t.string :presenter
      t.integer :conference_id
      t.integer :user_id

      t.timestamps
    end
  end
end
