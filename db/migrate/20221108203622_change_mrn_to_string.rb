class ChangeMrnToString < ActiveRecord::Migration[5.2]
  def change
    change_column :patients, :mrn, :string
  end
end
