class AddSeatsToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :seats, :integer
  end
end
