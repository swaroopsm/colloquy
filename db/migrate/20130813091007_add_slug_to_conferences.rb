class AddSlugToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :slug, :string, :unique => true
  end
end
