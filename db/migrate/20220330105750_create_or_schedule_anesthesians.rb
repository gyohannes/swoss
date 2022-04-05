class CreateOrScheduleAnesthesians < ActiveRecord::Migration[5.2]
  def change
    create_table :or_schedule_anesthesians, id: :uuid do |t|
      t.references :or_schedule, type: :uuid, foreign_key: true
      t.references :anesthesian, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
