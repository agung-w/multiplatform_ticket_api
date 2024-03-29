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

ActiveRecord::Schema[7.0].define(version: 2022_12_22_164902) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cinemas", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "poster_url"
    t.string "tmdb_id"
    t.decimal "vote_average"
    t.string "airing_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_id"
    t.integer "movie_id"
    t.bigint "user_id", null: false
    t.bigint "studio_id", null: false
    t.integer "quantity"
    t.decimal "sub_total"
    t.decimal "discount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "platform_fee"
    t.decimal "admin_fee"
    t.decimal "total"
    t.datetime "schedule", precision: nil
    t.index ["movie_id"], name: "index_orders_on_movie_id"
    t.index ["studio_id"], name: "index_orders_on_studio_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "studios", force: :cascade do |t|
    t.bigint "cinema_id", null: false
    t.string "code"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "row"
    t.integer "column"
    t.decimal "price"
    t.index ["cinema_id"], name: "index_studios_on_cinema_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.integer "cinema_id"
    t.integer "studio_id"
    t.string "seat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movie_id"
    t.datetime "schedule", precision: nil
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "user_id", null: false
    t.string "transaction_type"
    t.string "transaction_method"
    t.decimal "total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.text "phone_number"
    t.boolean "verified"
    t.string "country_code"
    t.string "reset_password_token"
    t.datetime "reset_password_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.string "uid"
    t.string "provider"
    t.index ["phone_number"], name: "index_users_on_phone_number"
  end

  create_table "verification_codes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "phone_number"
    t.string "code"
    t.datetime "expire_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_verification_codes_on_phone_number"
    t.index ["user_id"], name: "index_verification_codes_on_user_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "orders", "studios"
  add_foreign_key "orders", "users"
  add_foreign_key "studios", "cinemas"
  add_foreign_key "transactions", "orders"
  add_foreign_key "transactions", "users"
  add_foreign_key "verification_codes", "users"
  add_foreign_key "wallets", "users"
end
