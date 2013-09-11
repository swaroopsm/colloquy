class AddRowOrderToAllotments < ActiveRecord::Migration
  def change
    add_column :allotments, :row_order, :integer
  end
end
