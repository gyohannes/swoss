class AddAdmissionTimeToAdmission < ActiveRecord::Migration[5.2]
  def change
    add_column :admissions, :admission_time, :datetime
  end
end
