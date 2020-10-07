class CreateProcedures < ActiveRecord::Migration[5.2]
  def change
    create_table :procedures, id: :uuid do |t|
      t.string :name
      t.references :procedure_category, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
