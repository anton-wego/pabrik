# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_20_051042) do

  create_table "absens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "employee_id"
    t.date "absen_date"
    t.time "time_in"
    t.time "break_in"
    t.time "break_out"
    t.time "time_out"
    t.float "status"
    t.float "over_time_1", default: 0.0
    t.float "over_time_2", default: 0.0
    t.float "over_time_3", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_absens_on_employee_id"
  end

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nrp", limit: 15, default: "", null: false
    t.string "nmk", limit: 35, default: "", null: false
    t.string "dep", limit: 5, default: "", null: false
    t.string "sub_dep", limit: 5, default: "", null: false
    t.string "line", limit: 5, default: ""
    t.string "sex", limit: 1, default: "", null: false
    t.string "tmpt_lahir", limit: 15, default: "", null: false
    t.date "tgl_lahir"
    t.date "tgl_masuk"
    t.integer "lvl", limit: 2
    t.string "jabatan", limit: 20
    t.integer "status", limit: 2
    t.string "pendidikan", limit: 5
    t.string "jurusan", limit: 30
    t.string "gol_darah", limit: 3
    t.string "address_1"
    t.string "address_2"
    t.string "agama", limit: 10
    t.string "marital_status", limit: 10
    t.string "cat_1", limit: 10
    t.string "cat_2", limit: 10
    t.string "conper_1", limit: 10
    t.string "conper_2", limit: 10
    t.integer "cuti", default: 0
    t.integer "hak_cuti", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "month", limit: 2
    t.integer "year"
    t.integer "day_count"
    t.integer "workdays_count"
    t.float "over_time_1_count", default: 0.0
    t.float "over_time_2_count", default: 0.0
    t.float "over_time_3_count", default: 0.0
    t.string "over_time_salary_tot", default: "0.0"
    t.string "salary_one_month", default: "0.0"
    t.string "salary_one_month_tot", default: "0.0"
    t.string "salary_tot", default: "0.0"
    t.string "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
