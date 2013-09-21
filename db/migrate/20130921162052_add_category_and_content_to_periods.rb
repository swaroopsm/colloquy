class AddCategoryAndContentToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :category, :integer
    add_column :periods, :content, :text
  end
end
