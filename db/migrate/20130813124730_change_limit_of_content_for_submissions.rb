class ChangeLimitOfContentForSubmissions < ActiveRecord::Migration
  def change
  	change_column :submissions, :content, :text, :limit => 4294967295
  end
end
