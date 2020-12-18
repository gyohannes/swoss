class CreatePhoneCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_calls, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :admission, type: :uuid, foreign_key: true
      t.string :patient_response
      t.text :information
      t.string :action
      t.string :new_appointment

      t.timestamps
    end
  end
end
