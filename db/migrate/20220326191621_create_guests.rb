class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :lastname
      t.string :phone_number
      t.boolean :confirmed
      t.string :email
      t.references :parent_guest, null: true, foreign_key: { to_table: :guests }

      t.timestamps
    end
  end
end
