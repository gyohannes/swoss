class AddReasonToAdmissionStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :admission_statuses, :reason, :string
  end
end
