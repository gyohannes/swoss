class CreateProcedureCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :procedure_categories, id: :uuid do |t|
      t.integer :code
      t.integer :max_appointment_days
      t.integer :max_postponment_days

      t.timestamps
    end
  end
end
