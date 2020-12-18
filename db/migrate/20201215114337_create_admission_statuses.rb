class CreateAdmissionStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :admission_statuses, id: :uuid do |t|
      t.references :admission, type: :uuid, foreign_key: true
      t.string :status_date
      t.date :status_date_gr
      t.string :status
      t.string :reason

      t.timestamps
    end
  end
end
