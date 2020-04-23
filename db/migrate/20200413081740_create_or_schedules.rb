class CreateOrSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :or_schedules, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :admission, type: :uuid, foreign_key: true
      t.string :procedure_type
      t.references :surgeon, type: :uuid, foreign_key: true
      t.references :anesthesian, type: :uuid, foreign_key: true
      t.references :scrub_nurse, type: :uuid, foreign_key: true
      t.references :circulating_nurse, type: :uuid, foreign_key: true
      t.string :scheduled_date
      t.date :scheduled_date_gr
      t.time :scheduled_time
      t.references :schedule_order, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
