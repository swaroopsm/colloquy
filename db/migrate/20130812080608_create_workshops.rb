class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :content
      t.string :presenter
      t.string :conference_id
      t.string :user_id

      t.timestamps
    end
  end
end
