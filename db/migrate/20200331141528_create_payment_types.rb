class CreatePaymentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_types, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
