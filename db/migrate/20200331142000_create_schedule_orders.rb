class CreateScheduleOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_orders, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
