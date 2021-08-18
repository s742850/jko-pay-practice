class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :merchant_id, comment: '特店代碼,每家商店都不一樣', null: false
      t.string :store_id, comment: '商店編號', null: false
      t.string :gateway_trade_no, comment: '銀行端交易序號'
      t.string :merchant_trade_no, comment: '商店端交易序號,唯一值', null: false, :index => true
      t.string :pos_id, comment: 'POS機號', null: false
      t.string :trade_no, comment: '街口端交易序號', null: false
      t.string :trade_time, comment: '街口端交易日期時間 格式:yyyy/MM/dd HH:mm:ss', null: false
      t.integer :payment_type, comment: '付款方式', null: false
      t.integer :trade_amount, comment: '實際消費金額', null: false
      t.integer :debit_amount, comment: '付款方式扣款金額(折抵後金額)', null: false
      t.string :redeem_name, comment: '折抵方式', null: false
      t.integer :redeem_amount, comment: '街口折抵金額,此欄位為負值', null: true
      t.integer :store_redeem_amount, comment: '街口折抵金額,此欄位為負值,該筆交易有店家折抵才會回應此欄位', null: true
      t.integer :available_amount, comment: '儲值帳戶餘額', null: false
      t.string :invoice_vehicle, comment: '手機條碼發票載具資訊', null: true
      t.string :mer_mem_token, comment: '第三方合作廠商會員識別資訊', null: true
      t.string :remark, null: true
      t.string :extra1, null: true
      t.string :extra2, null: true
      t.string :extra3, comment: '信用卡資訊', null: true
      t.timestamps
    end
  end
end
