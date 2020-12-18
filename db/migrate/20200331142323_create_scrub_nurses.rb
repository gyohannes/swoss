class CreateScrubNurses < ActiveRecord::Migration[5.2]
  def change
    create_table :scrub_nurses, id: :uuid do |t|
      t.string :name
      t.references :hospital, type: :uuid, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
