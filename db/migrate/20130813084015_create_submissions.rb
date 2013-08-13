class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title
      t.text :authors
      t.text :content
      t.integer :conference_id
      t.integer :user_id
      t.integer :approved
      t.integer :preference
      t.string :bursary_for
      t.text :bursary_why

      t.timestamps
    end
  end
end
