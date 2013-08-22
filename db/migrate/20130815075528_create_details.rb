class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :gender
      t.date :dob
      t.string :academic
      t.string :institute_affiliation
      t.text :address
      t.string :phone
      t.string :nationality
      t.string :passport

      t.timestamps
    end
  end
end
