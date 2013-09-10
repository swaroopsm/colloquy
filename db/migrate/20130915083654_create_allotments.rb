class CreateAllotments < ActiveRecord::Migration
  def change
    create_table :allotments do |t|
      t.integer :period_id
      t.string :allotable_type
      t.integer :allotable_id

      t.timestamps
    end
  end
end
