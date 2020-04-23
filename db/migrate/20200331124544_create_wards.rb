class CreateWards < ActiveRecord::Migration[5.2]
  def change
    create_table :wards, id: :uuid do |t|
      t.string :name
      t.references :hospital, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
