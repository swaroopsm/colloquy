class AddSlugToPlenaries < ActiveRecord::Migration
  def change
    add_column :plenaries, :slug, :string, :unique => true
  end
end
