class CreateAdmissionStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :admission_statuses, id: :uuid do |t|
      t.references :admission, type: :uuid, foreign_key: true
      t.string :status
      t.date :status_date

      t.timestamps
    end
  end
end
