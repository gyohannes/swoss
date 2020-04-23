class CreateOrTables < ActiveRecord::Migration[5.2]
  def change
    create_table :or_tables, id: :uuid do |t|
      t.string :name
      t.string :code
      t.references :hospital, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
