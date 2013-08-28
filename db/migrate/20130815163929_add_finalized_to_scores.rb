class AddFinalizedToScores < ActiveRecord::Migration
  def change
    add_column :scores, :finalized, :boolean, :default => false
  end
end
