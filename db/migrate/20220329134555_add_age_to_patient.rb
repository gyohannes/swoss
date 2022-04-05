class AddAgeToPatient < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :age, :integer
    add_column :patients, :age_entry, :string
  end
end
