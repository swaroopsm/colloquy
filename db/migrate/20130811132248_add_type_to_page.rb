class AddTypeToPage < ActiveRecord::Migration
  def change
    add_column :pages, :type, :integer
  end
end
