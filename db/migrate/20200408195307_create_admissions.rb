class CreateAdmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :admissions, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :patient, type: :uuid, foreign_key: true
      t.string :date_of_registration
      t.date :date_of_registration_gr
      t.string :admission_type
      t.references :diagnosis, type: :uuid, foreign_key: true
      t.references :procedure, type: :uuid, foreign_key: true
      t.boolean :priority
      t.references :physician, type: :uuid, foreign_key: true
      t.references :department, type: :uuid, foreign_key: true
      t.string :listing_status
      t.text :information
      t.string :appointment_date
      t.date :appointment_date_gr
      t.string :admission_date
      t.date :admission_date_gr
      t.references :ward, type: :uuid, foreign_key: true
      t.string :reason_for_admission
      t.references :payment_type, type: :uuid, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
