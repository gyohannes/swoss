class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients, id: :uuid do |t|
      t.references :hospital, type: :uuid, foreign_key: true
      t.integer :mrn
      t.string :first_name
      t.string :father_name
      t.string :grand_father_name
      t.string :date_of_birth
      t.date :date_of_birth_gr
      t.integer :age
      t.string :sex
      t.references :region, type: :uuid, foreign_key: true
      t.string :zone
      t.string :woreda
      t.string :kebele
      t.string :house_number
      t.string :primary_telephone_number
      t.string :name_of_contact_person
      t.string :contact_person_telephone_number

      t.timestamps
    end
  end
end
