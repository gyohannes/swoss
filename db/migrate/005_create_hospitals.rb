class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals, id: :uuid do |t|
      t.string :name
      t.references :region, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
