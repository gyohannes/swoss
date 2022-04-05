class AddAnesthesiaTypeToOrSchedule < ActiveRecord::Migration[5.2]
  def change
    add_reference :or_schedules, :anesthesia_type, type: :uuid, foreign_key: true
  end
end
