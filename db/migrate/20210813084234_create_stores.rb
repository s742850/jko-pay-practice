class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :merchant_id
      t.string :name
      t.string :pos_id

      t.timestamps
    end
    add_index :stores, :merchant_id, unique: true
  end
end
