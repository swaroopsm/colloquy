class AddColumnToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :repeat, :boolean
  end
end
