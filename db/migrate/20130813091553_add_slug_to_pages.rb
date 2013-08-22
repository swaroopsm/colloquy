class AddSlugToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string, :unique => true
  end
end
