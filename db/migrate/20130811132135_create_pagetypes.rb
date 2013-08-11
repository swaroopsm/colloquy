class CreatePagetypes < ActiveRecord::Migration
  def change
    create_table :pagetypes do |t|
      t.string :type

      t.timestamps
    end
  end
end
