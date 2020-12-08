class CreateOrSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :or_schedules, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :admission, type: :uuid, foreign_key: true
      t.string :procedure_type
      t.references :surgeon, type: :uuid, foreign_key: true
      t.string :assisstant_surgeons, array: true
      t.integer :blood_units_required
      t.references :or_block, type: :uuid, foreign_key: true
      t.references :or_table, type: :uuid, foreign_key: true
      t.references :anesthesian, type: :uuid, foreign_key: true
      t.references :scrub_nurse, type: :uuid, foreign_key: true
      t.references :circulating_nurse, type: :uuid, foreign_key: true
      t.string :scheduled_date
      t.date :scheduled_date_gr
      t.time :scheduled_time

      t.timestamps
    end
  end
end
