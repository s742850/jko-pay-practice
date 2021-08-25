class CreateCancels < ActiveRecord::Migration[6.1]
  def change
    create_table :cancels do |t|
      t.string :merchant_id, comment: '特店代碼,每家商店都不一樣', null: false
      t.string :store_id, comment: '商店編號', null: false
      t.string :merchant_trade_no, comment: '商店端交易序號,唯一值', null: false
      t.string :pos_id, comment: 'POS機號', null: false
      t.integer :trade_amount, comment: '實際消費金額', null: false

      t.timestamps
    end
    add_index :cancels, :merchant_trade_no, unique: true
  end
end
