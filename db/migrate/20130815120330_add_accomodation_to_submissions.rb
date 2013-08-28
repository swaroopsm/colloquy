class AddAccomodationToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :accomodation, :boolean
  end
end
