class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.integer :number_of_days
      t.string :venue
      t.boolean :active

      t.timestamps
    end
  end
end
