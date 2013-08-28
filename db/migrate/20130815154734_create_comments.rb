class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :submission_id
      t.integer :user_id
      t.integer :category

      t.timestamps
    end
  end
end
