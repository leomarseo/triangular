# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_09_104440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.float "price"
    t.string "start_time"
    t.string "end_time"
    t.bigint "mask_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mask_id"], name: "index_listings_on_mask_id"
  end

  create_table "masks", force: :cascade do |t|
    t.string "description"
    t.string "condition"
    t.string "size"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.index ["user_id"], name: "index_masks_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "start_time"
    t.string "end_time"
    t.bigint "mask_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.index ["mask_id"], name: "index_reservations_on_mask_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.integer "rating"
    t.bigint "reservation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "listings", "masks"
  add_foreign_key "masks", "users"
  add_foreign_key "reservations", "masks"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "reservations"
end
