class CreateOccupationGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :occupation_groups, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
