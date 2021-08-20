# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_18_094126) do

  create_table "cancels", force: :cascade do |t|
    t.string "merchant_id", null: false
    t.string "store_id", null: false
    t.string "merchant_trade_no", null: false
    t.string "pos_id", null: false
    t.integer "trade_amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "merchant_id", null: false
    t.string "store_id", null: false
    t.string "gateway_trade_no"
    t.string "merchant_trade_no", null: false
    t.string "pos_id", null: false
    t.string "trade_no", null: false
    t.string "trade_time", null: false
    t.integer "payment_type", null: false
    t.integer "trade_amount", null: false
    t.integer "debit_amount", null: false
    t.string "redeem_name", null: false
    t.integer "redeem_amount"
    t.integer "store_redeem_amount"
    t.integer "available_amount", null: false
    t.string "invoice_vehicle"
    t.string "mer_mem_token"
    t.string "remark"
    t.string "extra1"
    t.string "extra2"
    t.string "extra3"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_trade_no"], name: "index_payments_on_merchant_trade_no"
  end

  create_table "refunds", force: :cascade do |t|
    t.string "merchant_id", null: false
    t.string "store_id", null: false
    t.string "gateway_trade_no"
    t.string "merchant_trade_no", null: false
    t.string "pos_id", null: false
    t.string "trade_no", null: false
    t.string "refund_trade_no", null: false
    t.string "refund_trade_time", null: false
    t.integer "payment_type", null: false
    t.string "redeem_name", null: false
    t.integer "redeem_amount"
    t.integer "store_redeem_amount"
    t.string "invoice_vehicle"
    t.string "mer_mem_token"
    t.string "remark"
    t.string "extra1"
    t.string "extra2"
    t.string "extra3"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_trade_no"], name: "index_refunds_on_merchant_trade_no"
  end

  create_table "stores", force: :cascade do |t|
    t.string "merchant_id"
    t.string "store_id"
    t.string "name"
    t.string "pos_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
