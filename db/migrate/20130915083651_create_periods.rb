class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :title
      t.integer :day

      t.timestamps
    end
  end
end
