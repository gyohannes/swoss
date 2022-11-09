class AddShortlistToAdmission < ActiveRecord::Migration[5.2]
  def change
    add_column :admissions, :shortlist, :boolean
  end
end
