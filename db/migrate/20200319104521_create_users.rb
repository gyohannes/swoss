class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :user_name
      t.string :email
      t.string :full_name
      t.string :role
      t.references :hospital, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
