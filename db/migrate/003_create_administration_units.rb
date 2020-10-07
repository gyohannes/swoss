class CreateAdministrationUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :administration_units, id: :uuid do |t|
      t.string :name
      t.string :category
      t.string :parent_administration_unit_id, type: :uuid
      t.boolean :status

      t.timestamps
    end
  end
end
