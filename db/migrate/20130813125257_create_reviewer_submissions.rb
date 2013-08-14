class CreateReviewerSubmissions < ActiveRecord::Migration
  def change
    create_table :reviewer_submissions do |t|
      t.integer :user_id
      t.integer :submission_id

      t.timestamps
    end
  end
end
