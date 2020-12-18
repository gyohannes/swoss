class CreateBeds < ActiveRecord::Migration[5.2]
  def change
    create_table :beds, id: :uuid do |t|
      t.references :ward, type: :uuid, foreign_key: true
      t.string :block
      t.integer :floor
      t.string :bed_number
      t.boolean :status

      t.timestamps
    end
  end
end
