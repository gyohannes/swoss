class CreateOrBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :or_blocks, id: :uuid do |t|
      t.string :name
      t.references :hospital, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
