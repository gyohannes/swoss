class CreateSurgicalServices < ActiveRecord::Migration[5.2]
  def change
    create_table :surgical_services, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :or_schedule, type: :uuid, foreign_key: true
      t.string :post_schedule_status
      t.string :reason_for_cancellation
      t.boolean :adverse_event_happened
      t.text :adverse_event
      t.string :date_operated
      t.date :date_operated_gr
      t.datetime :anesthesia_time
      t.datetime :incision_time
      t.datetime :surgery_end_time
      t.boolean :surgical_safety_checklist_completed
      t.string :immediate_postoperative_outcome
      t.string :reason_for_death

      t.timestamps
    end
  end
end
